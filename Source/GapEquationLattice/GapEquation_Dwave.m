treshold = 0.001; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T);

system = System_DWave();
system = system.createLattice();
system = system.generateHam();
computation = Computation(system); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
CORREL_C = zeros(system.Ny, system.Nx);
t = 1;
CORREL_C_trace = zeros(10,system.Ny, system.Nx);


delta_old = ones(system.Nx*system.Ny, 2); %angle and || of delta


%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system), 2);


fprintf('Solving the gap equation\n');
while (GapEquationBase.canLoop(t>150, dist, treshold, 2)) % last values gives how many DIFFEREBT parameters are to check per lattice site p(real, imag) is one param
    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising\n');
    delta_old = GapEquationBase.generateNewCollumnDeltaOrF(system);

    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system.hamiltonian);
    computation = computation.writeNewEigen(chi, ener);
    for i = 1: system.Nx * system.Ny %for each particle we search a convergence
        c_up_c_down = 0.0; %initialize the sum of the delta elements
        %Console.progressBar(i, system.Nx * system.Ny);
        %for each particle we calculate the delta element      
        %chi = (chi_1,..,chi_N) set of eigenvectors : as big as the matrix: to N_x
            %chi_n = (chi_n_1,..,chi_n_N )  each eigenvector has 2 components, which have also two compoennts: so 4
                %chi_n_i = (u_n_i, v_n_i) 2x1 bispinor
                    %u and v are 1x2 vector containing both a spin up and down part.
                    % Due to the form of ^c we set u_n=(u_nUP, u_nDOWN) and v_n=(v_nUP, v_nDOWN)

        %to each eigenvalue there is an eigenvector. So we get the right components of the eigenvector
        axis = ['x', 'y'];
        directions = [1, -1];
        for axis_id = 1:2 %x and y
            for direct_id =  1:2 %+1 and -1 directions

                F_dir = 0; %init F_dir on each particle space direction
                can_compute = true;
                if (x == 1 && direction_id == 2 && axis_id == 1) %-x
                    can_compute = ~isempty(system_fourier.points{x}.neighbour{2}); 

                elseif (x == system_fourier.Nx && direction_id == 1 && axis_id == 1) %+x
                    can_compute = ~isempty(system_fourier.points{x}.neighbour{1});

                elseif (y == 1 && direction_id == 2 && axis_id == 2) %-y
                    can_compute = ~isempty(system_fourier.points{y}.neighbour{4});
                elseif (y == system_fourier.Ny && direction_id == 1 && axis_id == 2) %+y
                    can_compute = ~isempty(system_fourier.points{y}.neighbour{3});
                end
                if can_compute  
                    for index_eigen = 1 : numel(computation.n) %sum over n, the numbers of eigenvectors with POSITIVE energies.
                        n = computation.n(index_eigen);
                        if strcmp(axis_id, 'x')
                            j = i + directions(direct_id);
                        else
                            j = i + directions(direct_id) * system.Nx;
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
        system_fourier.points{x} = system_fourier.points{x}.updateF(F_x, F_y);
    end


    %correct Hamiltonian
    for i = 1: system.Nx * system.Ny
        system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = system.onSiteMatrix(i); %This takes the most time in the loop.
    end

    t = t+1;
    dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system), 2);

    abs_dist_abs = abs(dist(:,1,1));
    abs_dist_phase = abs(dist(:,1,2));
    [x_valu, x_id] = max(abs_dist_abs);
    [y_valu, y_id] = max(abs_dist_phase);
    fprintf('convergence  ABS = %.5f %% at %d, PHASE = %.5f %% at x=%d | old norm: %d, old angle %d', ...
        dist(x_id,1,1), x_id, dist(y_id,1,2), mod(y_id-1,30) +1, delta_old(x_id, 1),delta_old(x_id, 2));
end 

%generate a plotable matrix
for i = 1: system.Nx * system.Ny
    %disp(system.points{i}.delta);
    CORREL_C(system.points{i}.y, system.points{i}.x) = system.points{i}.c_up_c_down;
end   


fprintf('Computing currents\n');
system = ComputeCurrents(system, computation); % return a 2*Nx*Ny X Nx*Ny matrix


sim_deltails = GapEquationBase.getSimulationDetails(system);

systemMaterial = GapEquationBase.getSimMaterial();
path = strcat(".\Results\", systemMaterial);
phase_shift_folder = GapEquationBase.getPhaseShiftFolder(system);

folder = strcat(path, '\NotFourier', phase_shift_folder);
if not(isfolder(folder))
    mkdir(folder);
end

GapEquationBase.saveResults(folder, sim_deltails, system, CORREL_C);

