treshold = 0.001; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T, SystemBase.mu);

system_fourier = SystemFourier();
system_fourier = system_fourier.createLattice();
system_fourier = system_fourier.generateHam();
computation = Computation(system_fourier); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
CORREL_C = zeros(system_fourier.Ny, system_fourier.Nx);
t = 1;
CORREL_C_trace = zeros(10,system_fourier.Ny, system_fourier.Nx);


delta_old = ones(system_fourier.Nx*system_fourier.Ny, 1);


%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(delta_old, generateNewCollumnDelta(system_fourier));


fprintf('Solving the gap equation\n');
while (GapEquationBase.canLoop(false, dist, treshold)) 

    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising');
    delta_old = GapEquationBase.generateNewCollumnDelta(system_fourier);
    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system_fourier.hamiltonian);
    computation = computation.writeNewEigen(chi, ener);

    for i = 1: system_fourier.Nx%for each particle we search a convergence
        c_up_c_down = 0.0; %initialize the sum of the delta elements
        Console.progressBar(i, system_fourier.Nx * system_fourier.Ny);
        %for each particle we calculate the delta element      
        %chi = (chi_1,..,chi_N) set of eigenvectors : as big as the matrix: to N_x
            %chi_n = (chi_n_1,..,chi_n_N )  each eigenvector has 2 components, which have also two compoennts: so 4
                %chi_n_i = (u_n_i, v_n_i) 2x1 bispinor
                    %u and v are 1x2 vector containing both a spin up and down part.
                    % Due to the form of ^c we set u_n=(u_nUP, u_nDOWN) and v_n=(v_nUP, v_nDOWN)

        %to each eigenvalue there is an eigenvector. So we get the right components of the eigenvector
        %disp(numel(computation.E));
        F_x = [0,0];
        F_y = [0,0];
        axis = ['x', 'y'];
        direction = [1,-1];
        for axis_id = 1 : 2 %x, y
            for direction_id = 1 : 2 %F_x_plus, F_x_minus, F_y_plus, F_y_minus 
                if (i == 1 && direction_id == 2 && axis_id == 1) ...
                    || (i == system_fourier.Nx  && direction_id == 1 && axis_id == 1)
                    F_dir = 0; %no +- Fx on the sides
                else
                    for k_id = 1 : system_fourier.Ny
                        for index_eigen = 1 : numel(computation.n) %sum over n, the numbers of eigenvectors with POSITIVE energies.
                            n = computation.n(index_eigen);

                            %first we need our both eigenvector components, u is spin up and v spin down
                            if axis_id == 1
                                u_nxk = computation.eigenvectors(2*(x - 1) + 1, n, k);
                                v_nxk = computation.eigenvectors(2*(x - 1 + direction(direction_id)) + 2, n, k); %here we need the \pm 1
                                rot = 0;
                            else
                                [u_nxk, v_nxk] = computation.GetUVatXK(x, n, k);
                                rot = -1 * direction(direction_id);
                            end
                            % then we compute the summand

                            F_dir = F_dir + u_nxk * conj (v_nxk) * ( 1 - Fermi(1*computation.E(n))) * exp(1i*rot* system_fourier.k(k_id));
                        end
                    end
                end
                F_dir =  F_dir / system_fourier.Ny;


                if strcmp(axis(direction_id), 'x')
                    if direction_id == 1
                        F_x(1) = F_dir;
                    else 
                        F_x(2) = F_dir;
                    end
                else
                    if direction_id == 1
                        F_y(1) = F_dir;
                    else 
                        F_y(2) = F_dir;
                    end
                end
            end
        end
    end

    system_fourier.points{i}.F_x = F_x;
    system_fourier.points{i}.F_y = F_y;

    %TODO from hee.
    %correct Hamiltonian
    for i = 1: system_fourier.Nx * system_fourier.Ny
        system_fourier.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = system_fourier.onSiteMatrix(i); %This takes the most time in the loop.
    end

    t = t+1;
    dist = GapEquationBase.computeDistance(delta_old, generateNewCollumnDelta(system_fourier));

    abs_dist_re = abs(dist(:,1));
    abs_dist_im = abs(dist(:,2));
    [x_valu, x_id] = max(abs_dist_re);
    [y_valu, y_id] = max(abs_dist_im);
    fprintf('convergence  RE = %.5f %% at %d, IM = %.5f %% at %d : re:%d, im: %d\n', ...
      dist(x_id,1), x_id, dist(y_id,2), y_id, real(system_fourier.points{x_id}.delta),  imag(system_fourier.points{x_id}.delta));
end 

%generate a plotable matrix
for i = 1: system_fourier.Nx * system_fourier.Ny
    %disp(system.points{i}.delta);
    CORREL_C(system_fourier.points{i}.y, system_fourier.points{i}.x) = abs(system_fourier.points{i}.c_up_c_down);
end   


fprintf('Computing currents\n');
system_fourier = ComputeCurrents(system_fourier, computation); % return a 2*Nx*Ny X Nx*Ny matrix


sim_deltails = GapEquationBase.getSimulationDetails();


path = strcat(".\Results\", systemMaterial);
phase_shift_folder = GapEquationBase.getPhaseShiftFolder();


phase_shift_folder = strcat(phase_shift_folder,"diffMU\", num2str(SystemBase.mu),"\", "LinearPhaseGradient\", num2str(SystemBase.phi_1),"\");
if not(isfolder(strcat(path, phase_shift_folder)))
    mkdir(strcat(path, phase_shift_folder));
end


GapEquationBase.saveResults(strcat(path, phase_shift_folder), system_fourier, CORREL_C)

