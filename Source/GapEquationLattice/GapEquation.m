


treshold = 0.001; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T);

system = System();
system = system.createLattice(false); %use the tilted interface version
system = system.generateHam();
computation = Computation(system); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
CORREL_C = zeros(system.Ny, system.Nx);
t = 1;


delta_old = ones(system.Nx*system.Ny, 2); %angle and || of delta


%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system), 2, system.convergence_model);


fprintf('Solving the gap equation\n');
trace = zeros(200, 3);
while (GapEquationBase.canLoop(t>200, dist, treshold, 2, 're')) % last values gives how many DIFFEREBT parameters are to check per lattice site p(real, imag) is one param
    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising\n');
    delta_old = GapEquationBase.generateNewCollumnDeltaOrF(system);

    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system.hamiltonian);
    computation = computation.writeNewEigen(chi, ener); %* ok
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

        for index_eigen = 1 : numel(computation.n) %sum over n, the numbers of eigenvectors with POSITIVE energies.
            n = computation.n(index_eigen);
            [u_i_n, v_i_n] = computation.GetUVatI(i, n);

            c_up_c_down = c_up_c_down + u_i_n(1) * conj(v_i_n(2)) * (1- Fermi(computation.E(n)))...
                + u_i_n(2) * conj(v_i_n(1)) * (Fermi(computation.E(n))) ; %spin-dep variables in H are
                % defined with general spin sigma and delta with up or down

            assert(computation.E(n) > 0, sprintf('E(n) = %.5f', computation.E(n)));
            % if i == 120
            %     fprintf('u = %.5f, v = %.5f, E = %.5f\n', u_i_n(1), v_i_n(2), computation.E(n));
            % end
        end
        system.points{i} = system.points{i}.updateDelta(c_up_c_down, system); 
        % if i == 150
        %     fprintf('c_up_c_down = %.5f\n', system.points{i}.c_up_c_down);
        % end
    end

    %correct Hamiltonian
    for i = 1: system.Nx * system.Ny
        system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = system.onSiteMatrix(i); %This takes the most time in the loop.
        % if i==150
        %     disp(system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4));
        % end#    
        CORREL_C(system.points{i}.y, system.points{i}.x) = system.points{i}.c_up_c_down;
    end
    % disp(CORREL_C);
    t = t+1;
    dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system), 2,  system.convergence_model);

    abs_dist_abs = abs(dist(:,1,1));
    abs_dist_phase = abs(dist(:,1,2));
    [x_valu, x_id] = max(abs_dist_abs);
    [y_valu, y_id] = max(abs_dist_phase);
    fprintf('convergence  ABS = %.5f %% at %d, PHASE = %.5f %% at x=%d | old norm: %d, old angle %d\n', ...
        dist(x_id,1,1), x_id, dist(y_id,1,2), mod(y_id-1,30) +1, delta_old(x_id, 1),delta_old(x_id, 2));

    total = 0;
    for j = 1: system.Nx * system.Ny
        total = total + abs(system.points{j}.c_up_c_down);
    end

    trace(t,:) = [t, dist(1,1,1), total];
    %disp(CORREL_C)

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
writematrix(trace, strcat(folder,'trace.dat'), 'Delimiter', ' ');
GapEquationBase.saveResults(folder, sim_deltails, system, CORREL_C);

