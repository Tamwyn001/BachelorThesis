treshold = 0.001; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T, SystemBase.mu);

system = SystemFourier();
system = system.createLattice();
system = system.generateHam();
computation = Computation(system); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
CORREL_C = zeros(system.Ny, system.Nx);
t = 1;
CORREL_C_trace = zeros(10,system.Ny, system.Nx);

if system.fixedBoundaryDelta
    delta_old = ones(system.Nx*(system.Ny-2), 1); %subtract the sides 2 Nx elements
else
    delta_old = ones(system.Nx*system.Ny, 1);
end

%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(delta_old, generateNewCollumnDelta(system));


fprintf('Solving the gap equation\n');
while (GapEquationBase.canLoop(false, dist, treshold)) 

    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising');
    delta_old = GapEquationBase.generateNewCollumnDelta(system);
    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system.hamiltonian);
    computation = computation.writeNewEigen(chi, ener);

    for i = 1: system.Nx * system.Ny %for each particle we search a convergence
        c_up_c_down = 0.0; %initialize the sum of the delta elements
        Console.progressBar(i, system.Nx * system.Ny);
        %for each particle we calculate the delta element      
        %chi = (chi_1,..,chi_N) set of eigenvectors : as big as the matrix: to N_x
            %chi_n = (chi_n_1,..,chi_n_N )  each eigenvector has 2 components, which have also two compoennts: so 4
                %chi_n_i = (u_n_i, v_n_i) 2x1 bispinor
                    %u and v are 1x2 vector containing both a spin up and down part.
                    % Due to the form of ^c we set u_n=(u_nUP, u_nDOWN) and v_n=(v_nUP, v_nDOWN)

        %to each eigenvalue there is an eigenvector. So we get the right components of the eigenvector
        %disp(numel(computation.E));
        for n = numel(computation.E)/2 + 1 : numel(computation.E) %numel(computation.E)/2+1 : numel(computation.E) %sum over n, n numbers of eigenvectors with POSITIVE energies.
            [u_i_n, v_i_n] = GetUVatI(computation, i, n);

            c_up_c_down = c_up_c_down + conj(v_i_n(1)) * u_i_n(2) *  Fermi(computation.E(n)) ...
                + u_i_n(1) * conj(v_i_n(2)) * (1-Fermi(computation.E(n))); %spin-dep variables in H are
                % defined with general spin sigma and delta with up or dow
        end
        system.points{i} = system.points{i}.updateDelta(c_up_c_down, system); %system.points{i}.U *      


    end

    %correct Hamiltonian
    for i = 1: system.Nx * system.Ny
        system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = system.onSiteMatrix(i); %This takes the most time in the loop.
    end

    t = t+1;
    dist = GapEquationBase.computeDistance(delta_old, generateNewCollumnDelta(system));

    abs_dist_re = abs(dist(:,1));
    abs_dist_im = abs(dist(:,2));
    [x_valu, x_id] = max(abs_dist_re);
    [y_valu, y_id] = max(abs_dist_im);
    fprintf('convergence  RE = %.5f %% at %d, IM = %.5f %% at %d : re:%d, im: %d\n', ...
      dist(x_id,1), x_id, dist(y_id,2), y_id, real(system.points{x_id}.delta),  imag(system.points{x_id}.delta));
end 

%generate a plotable matrix
for i = 1: system.Nx * system.Ny
    %disp(system.points{i}.delta);
    CORREL_C(system.points{i}.y, system.points{i}.x) = abs(system.points{i}.c_up_c_down);
end   


fprintf('Computing currents\n');
system = ComputeCurrents(system, computation); % return a 2*Nx*Ny X Nx*Ny matrix


sim_deltails = GapEquationBase.getSimulationDetails();


path = strcat(".\Results\", systemMaterial);
phase_shift_folder = GapEquationBase.getPhaseShiftFolder();


phase_shift_folder = strcat(phase_shift_folder,"diffMU\", num2str(SystemBase.mu),"\", "LinearPhaseGradient\", num2str(SystemBase.phi_1),"\");
if not(isfolder(strcat(path, phase_shift_folder)))
    mkdir(strcat(path, phase_shift_folder));
end


GapEquationBase.saveResults(strcat(path, phase_shift_folder), system, CORREL_C)

