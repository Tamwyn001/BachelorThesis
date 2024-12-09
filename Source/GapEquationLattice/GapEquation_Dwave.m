treshold = 0.001; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T);

system_d_wave = System_DWave();
system_d_wave = system_d_wave.createLattice();
system_d_wave = system_d_wave.generateHam();
computation = Computation(system_d_wave); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
Delta_D = zeros(system_d_wave.Ny, system_d_wave.Nx);
t = 1;


delta_old = ones(system_d_wave.Nx*system_d_wave.Ny, 2); %angle and || of delta


%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave), 1, system_d_wave.convergence_model);


fprintf('Solving the gap equation\n');
while (GapEquationBase.canLoop(t>150, dist, treshold, 2)) % last values gives how many DIFFEREBT parameters are to check per lattice site p(real, imag) is one param
    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising\n');
    delta_old = GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave);

    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system_d_wave.hamiltonian);
    computation = computation.writeNewEigen(chi, ener);
    for i = 1: system_d_wave.Nx * system_d_wave.Ny %for each particle we search a convergence

        axis = ['x', 'y'];
        directions = [1, -1];
        F_x = [0, 0];
        F_y = [0, 0];
        for axis_id = 1:2 %x and y
            for direct_id =  1:2 %+1 and -1 directions

                F_dir = 0; %init F_dir on each particle space direction
                can_compute = true;
                if (x == 1 && direction_id == 2 && axis_id == 1) %-x
                    can_compute = ~isempty(system_d_wave.points{x}.neighbour{2}); 

                elseif (x == system_d_wave.Nx && direction_id == 1 && axis_id == 1) %+x
                    can_compute = ~isempty(system_d_wave.points{x}.neighbour{1});

                elseif (y == 1 && direction_id == 2 && axis_id == 2) %-y
                    can_compute = ~isempty(system_d_wave.points{y}.neighbour{4});
                elseif (y == system_d_wave.Ny && direction_id == 1 && axis_id == 2) %+y
                    can_compute = ~isempty(system_d_wave.points{y}.neighbour{3});
                end
                if can_compute  
                    for index_eigen = 1 : numel(computation.n) %sum over n, the numbers of eigenvectors with POSITIVE energies.
                        n = computation.n(index_eigen);
                        if strcmp(axis_id, 'x')
                            j = i + directions(direct_id);
                        else
                            j = i + directions(direct_id) * system_d_wave.Nx;
                        end
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
                    continue;
                end
                
            end
        end

        %we asign the values
        system_d_wave.points{x} = system_d_wave.points{x}.updateF(F_x, F_y);
    end


    %correct Hamiltonian with Fij on neighbours interaction elems
    for i = 1: system_d_wave.Nx * system_d_wave.Ny
        for j = 1 : numel(system.points{i}.neighbour)
            if ~isempty(system.points{i}.neighbour{j})
                if j == 1
                    axe = '+x';
                elseif j == 2
                    axe = '-x';
                elseif j == 3
                    axe = '+y';
                elseif j == 4
                    axe = '-y';
                end
                i_prime = system.points{i}.neighbour{j}.i;
                assert(i_prime ~= 0, 'Neighbouring system foesnt works, pleas asign an i to the neighbour');

                system_d_wave.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i_prime-1) + 1: 4*(i_prime-1) + 4) = ...
                    system_d_wave.neighbourMatrix(i, axe);
            end
        end
    end

    t = t+1;

    %for each site and k we pass the uv of the neighbours to compute the d-wave parameter 
    system_d_wave.points{i} = system_d_wave.points{i}.computeDWave(system_d_wave); %compute all the d-wave parameter

    dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave), 1, system_d_wave.convergence_model);

    abs_dist_abs = abs(dist(:,1,1));
    abs_dist_phase = abs(dist(:,2,1));
    [x_valu, x_id] = max(abs_dist_abs);
    [y_valu, y_id] = max(abs_dist_phase);
    fprintf('convergence\n F_d ABS = %.5f %% at %d, PHASE = %.5f %% at x=%d | old norm: %d, old angle %d', ...
        x_valu, x_id ,y_valu, mod(y_id-1,30) +1, delta_old(x_id, 1),delta_old(x_id, 2));
end 

%generate a plotable matrix
for i = 1: system_d_wave.Nx * system_d_wave.Ny
    Delta_D(system_d_wave.points{i}.y, system_d_wave.points{i}.x) = system_d_wave.points{i}.Delta_D;
end   


fprintf('Computing currents\n');
system_d_wave = ComputeCurrents(system_d_wave, computation); % return a 2*Nx*Ny X Nx*Ny matrix


sim_deltails = GapEquationBase.getSimulationDetails(system_d_wave);

systemMaterial = GapEquationBase.getSimMaterial();
path = strcat(".\Results\", systemMaterial);
phase_shift_folder = GapEquationBase.getPhaseShiftFolder(system_d_wave);

folder = strcat(path, '\NotFourier', phase_shift_folder);
if not(isfolder(folder))
    mkdir(folder);
end

GapEquationBase.saveResults(folder, sim_deltails, system_d_wave, Delta_D);

