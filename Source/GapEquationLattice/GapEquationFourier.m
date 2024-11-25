


treshold = 0.001; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T, SystemBase.mu);

system_fourier = SystemFourier();
system_fourier = system_fourier.createLattice();
system_fourier = system_fourier.generateHam(true);
computation = Computation(system_fourier); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
t = 1;
CORREL_C_trace = zeros(10,system_fourier.Ny, system_fourier.Nx);


delta_old = ones(system_fourier.Nx*system_fourier.Ny, 1);


%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system_fourier), 4);

chi = zeros(2 * system_fourier.Nx, 2 * system_fourier.Nx, system_fourier.Ny);
ener = zeros(2 * system_fourier.Nx, 2 * system_fourier.Nx, system_fourier.Ny);

fprintf('Solving the gap equation\n');
while (GapEquationBase.canLoop(false, dist, treshold)) 

    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising');
    delta_old = GapEquationBase.generateNewCollumnDeltaOrF(system_fourier);
    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
   
    for k_id = 1 : SystemeBase.Ny
        [chi(:, :, k_id),  ener(:,:,k_id)] = eig(system_fourier.hamiltonian(:, :, k_id));
    end
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
                        for n = 1 : size(computation.E, 1) %sum over n, the numbers of eigenvectors. %?No sorting needed, we include all DOF?
                            %first we need our both eigenvector components, u is spin up and v spin down
                            if axis_id == 1 %along x
                                u_nxk = computation.eigenvectors(2*(x - 1) + 1, n, k);
                                v_nxk = computation.eigenvectors(2*(x - 1 + direction(direction_id)) + 2, n, k); %here we need the \pm 1
                                rot = 0;
                            else %along y
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

    %correct Hamiltonian
    system_fourier = system_fourier.generateHam(false);

    t = t+1;
    dist = GapEquationBase.computeDistance(delta_old, GapEquationBase.generateNewCollumnDeltaOrF(system_fourier), 4);

    abs_dist_re_px = abs(dist(:, 1, 1));
    abs_dist_re_mx = abs(dist(:, 1, 2));
    abs_dist_re_py = abs(dist(:, 1, 3));
    abs_dist_re_my = abs(dist(:, 1, 4));

    abs_dist_im_px = abs(dist(:, 1, 1));
    abs_dist_im_mx = abs(dist(:, 1, 2));
    abs_dist_im_py = abs(dist(:, 1, 3));
    abs_dist_im_my = abs(dist(:, 1, 4));

    [re_valu_px, re_id_px] = max(abs_dist_re_px);
    [re_valu_mx, re_id_mx] = max(abs_dist_re_mx);
    [re_valu_py, re_id_py] = max(abs_dist_re_py);
    [re_valu_my, re_id_my] = max(abs_dist_re_my);

    [im_valu_px, im_id_px] = max(abs_dist_im_px);
    [im_valu_mx, im_id_mx] = max(abs_dist_im_mx);
    [im_valu_py, im_id_py] = max(abs_dist_im_py);
    [im_valu_my, im_id_my] = max(abs_dist_im_my);
    
    fprintf('convergence\n  F+x re: %.3f, im: %.3f\n     F-x re: %.3f, im: %.3f\n   F+y re: %.3f, im: %.3f\n    F-y re: %.3f, im: %.3f\n', ...
        re_valu_px, im_valu_px, re_valu_mx, im_valu_mx,  re_valu_py, im_valu_py, re_valu_my, im_valu_my);
    
end 

Delta_d = zeros(system_fourier.Nx, 1);
for i = 1 : SystemBase.Nx
    uv_for_site_and_neigbours = zeros(3, 2 * system.Nx, system.Ny, 2); %sites(x-1, x, x+1) x n x k x (u,v)
        for n_id = 1 : numel(computation.n)
            n = computation.n(n_id);
            for k_id = 1 : system.Ny
                k = system.k(k_id);
                for target_site = -1 : 1
                %here we need to remap the site to + 2 to get from 1 to 3.
                %1: x-1, 2: x, 3: x+1
                uv_for_site_and_neigbours(target_site + 2, n_id, k_id, :) = computation.GetUVatXK(x + target_site, n, k);
                end
                
            end
        end
    system.points{i} = system.points{i}.computeDWave(system, uv_for_site_and_neigbours, computation.E); %compute all the d-wave parameter

    Delta_d(system_fourier.points{i}.x) = system_fourier.points{i}.Delta_d;
end

fprintf('Computing currents\n');
%system_fourier = ComputeCurrents(system_fourier, computation); % return a 2*Nx*Ny X Nx*Ny matrix


sim_deltails = GapEquationBase.getSimulationDetails();
path = strcat(".\Results\", systemMaterial);
phase_shift_folder = GapEquationBase.getPhaseShiftFolder();


phase_shift_folder = strcat(phase_shift_folder,"diffMU\", num2str(SystemBase.mu),"\", "LinearPhaseGradient\", num2str(SystemBase.phi_1),"\");
if not(isfolder(strcat(path, phase_shift_folder)))
    mkdir(strcat(path, phase_shift_folder));
end

path_CORREL_C = strcat(strcat(path, phase_shift_folder), sim_deltails);
disp(path_CORREL_C);
writematrix(WriteHeatmap(system, 'correl_c_c'), strcat(path_CORREL_C, 'Delta_D.dat'),'Delimiter',' ')

