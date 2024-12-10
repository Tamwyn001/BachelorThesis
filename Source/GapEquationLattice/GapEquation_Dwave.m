treshold = 0.1; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T);

system_d_wave = System_DWave();
system_d_wave = system_d_wave.createLattice(true); %use the tilted interface version
system_d_wave = system_d_wave.generateHam();
computation = Computation(system_d_wave); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
Delta_D = zeros(system_d_wave.Ny, system_d_wave.Nx);
t = 1;


F_d_old = 10 .* ones(system_d_wave.Nx*system_d_wave.Ny, 1); %angle and || of delta


%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(F_d_old, GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave), 1, system_d_wave.convergence_model);

fprintf('Solving the gap equation\n');
while (GapEquationBase.canLoop(t>50, dist, treshold, 1)) % last values gives how many DIFFEREBT parameters are to check per lattice site p(real, imag) is one param
    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising\n');
    F_d_old = GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave);

    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system_d_wave.hamiltonian);
    computation = computation.writeNewEigen(chi, ener);
    for i = 1: numel(system_d_wave.points) %for each particle we search a convergence

        axis = ['x', 'y'];
        directions = [1, -1];
        F_x = [0, 0];
        F_y = [0, 0];
        for axis_id = 1:2 %x and y
            for direction_id = 1:2 %+1 and -1 directions

                F_dir = 0; %init F_dir on each particle space direction
                can_compute = true;
                if (direction_id == 1 && axis_id == 2) %+y
                    can_compute = ~isempty(system_d_wave.points{i}.neighbour{2}); 
                    nei_id = 2;

                elseif (direction_id == 1 && axis_id == 1) %+x
                    can_compute = ~isempty(system_d_wave.points{i}.neighbour{1});
                    nei_id = 1;
                elseif (direction_id == 2 && axis_id == 2) %-y
                    can_compute = ~isempty(system_d_wave.points{i}.neighbour{4});
                    nei_id = 4;
                elseif (direction_id == 2 && axis_id == 1) %-x
                    can_compute = ~isempty(system_d_wave.points{i}.neighbour{3});
                    nei_id = 3;
                end
                if can_compute  
                    j = system_d_wave.points{i}.neighbour{nei_id}.i;

                    for index_eigen = 1 : numel(computation.n) %sum over n, the numbers of eigenvectors with POSITIVE energies.
                        n = computation.n(index_eigen);

                        [u_i_n, v_i_n] = computation.GetUVatI(i, n);
                        [u_j_n, v_j_n] = computation.GetUVatI(j, n);


                        F_dir = F_dir + u_i_n(1) * conj(v_j_n(2)) * (1- Fermi(1*computation.E(n)))...
                            + u_i_n(2) * conj(v_j_n(1)) *   (Fermi(1*computation.E(n))) ; %spin-dep variables in H are
                            % defined with general spin sigma and delta with up or down
                    end

                    %asign the computed F to the right variable in axis and direction
                    if strcmp(axis(axis_id), 'x')
                        if direction_id == 1 %+x
                            F_x(1) = F_dir;
                        else  %-x
                            F_x(2) = F_dir;
                        end
                    else
                        if direction_id == 1 %+y
                            F_y(1) = F_dir;
                        else    %-y
                            F_y(2) = F_dir;
                        end
                    end
                else
                    %fprintf('cant compute at %d', x);
                end
                
            end
        end

        %we asign the values
        system_d_wave.points{i} = system_d_wave.points{i}.updateF(F_x, F_y);
        system_d_wave.points{i} = system_d_wave.points{i}.computeDWave(system_d_wave); %compute all the d-wave parameter
    end


    %correct Hamiltonian with Fij on neighbours interaction elems
    for i = 1: system_d_wave.Nx * system_d_wave.Ny
        for j = 1 : 4 %neighbours
            if ~isempty(system_d_wave.points{i}.neighbour{j})

                if j == 1
                    axe = '+x';
                elseif j == 2
                    axe = '+y';
                elseif j == 3
                    axe = '-x';
                elseif j == 4
                    axe = '-y';
                end

                i_prime = system_d_wave.points{i}.neighbour{j}.i;
                assert(i_prime ~= 0 && ~isempty(i_prime), 'Neighbouring system doesnt work, please asign an i to the neighbour');

                system_d_wave.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i_prime-1) + 1: 4*(i_prime-1) + 4) = ...
                    system_d_wave.neighbourMatrix(i, axe);
                % if i == 250
                %     fprintf('Corrected Hamiltonian at %d, %d with\n', i, i_prime);
                %     disp(system_d_wave.neighbourMatrix(i, axe));
                % end
            end
        end
    end

    t = t+1;

    %for each site and k we pass the uv of the neighbours to compute the d-wave parameter 
    a = GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave);
    dist = GapEquationBase.computeDistance(F_d_old, GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave), 1, system_d_wave.convergence_model);

    abs_dist_abs = abs(dist(:,1,1));
    abs_dist_phase = abs(dist(:,2,1));
    [x_valu, x_id] = max(abs_dist_abs);
    [y_valu, y_id] = max(abs_dist_phase);
    fprintf('convergence\n F_d ABS = %.5f %% at %d, PHASE = %.5f %% at x=%d | old norm: %d, old angle %d', ...
        x_valu, x_id ,y_valu, mod(y_id-1,30) +1, abs(F_d_old(x_id, 1)), angle(F_d_old(x_id, 1)));
end 

%generate a plotable matrix
for i = 1: system_d_wave.Nx * system_d_wave.Ny
    Delta_D(system_d_wave.points{i}.y, system_d_wave.points{i}.x) = system_d_wave.points{i}.Delta_d;
end   


fprintf('Computing currents\n');
system_d_wave = ComputeCurrents(system_d_wave, computation); % return a 2*Nx*Ny X Nx*Ny matrix


sim_deltails = GapEquationBase.getSimulationDetails(system_d_wave);

systemMaterial = GapEquationBase.getSimMaterial();
path = strcat(".\Results\", systemMaterial);
phase_shift_folder = GapEquationBase.getPhaseShiftFolder(system_d_wave);

folder = strcat(path, '\DWave', phase_shift_folder);
if not(isfolder(folder))
    mkdir(folder);
end

path_CORREL_C = strcat(folder, sim_deltails);
disp(path_CORREL_C);
writematrix(WriteHeatmap(system_d_wave, 'F_d'), strcat(path_CORREL_C, '_F_D10.dat'),'Delimiter',' ')

path_MEAN_CORREL_C = strcat(folder, "meanline_",sim_deltails);
writematrix(MeanLineMatrix(Delta_D, 'abs'), strcat(path_MEAN_CORREL_C, '_F_D10.dat'),'Delimiter',' ');

