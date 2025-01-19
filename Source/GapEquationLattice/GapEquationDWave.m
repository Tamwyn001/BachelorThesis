treshold = 0.001; %convergence treshold in percentage of change
Fermi = @(E) FermiDiarac(E, SystemBase.T);

system_d_wave = System_DWave();
system_d_wave = system_d_wave.createLattice(false); %use the tilted interface version
system_d_wave = system_d_wave.generateHam();
computation = Computation(system_d_wave); %holds the eigenvalues and eigenvectors to access them later without passing huge matrices around
Delta_D = zeros(system_d_wave.Ny, system_d_wave.Nx);
t = 1;


F_d_old = 10 .* ones(system_d_wave.Nx*system_d_wave.Ny, 1); %angle and || of delta


%seting the value to compare with after its going to be updated
dist = GapEquationBase.computeDistance(F_d_old, GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave), 1, system_d_wave.convergence_model);
trace = zeros(30, 3);
debug = zeros(system_d_wave.Ny, system_d_wave.Nx);
fprintf('Solving the gap equation\n');

while (GapEquationBase.canLoop(t>60, dist, treshold, 1, 'all')) % last values gives how many DIFFEREBT parameters are to check per lattice site p(real, imag) is one param
    fprintf('\n\nIteration %d:\n', t);
    fprintf('Diagonalising\n');
    disp(ishermitian(system_d_wave.hamiltonian));
    F_d_old = GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave);

    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system_d_wave.hamiltonian);
    
    computation = computation.writeNewEigen(chi, ener);

    fprintf('Correcting\n');
    Console.progressBar(0, numel(system_d_wave.points));
    %recompute F_d_i. we already have F_+x etc, now we need F _i+1,i as well for F_ds
    for i = 1: numel(system_d_wave.points)
        uv_for_site_and_neigbours = zeros(5, numel(computation.n), 4); %sites(x, x+1, y+1, x-1, y-1) x n x (u_up, u_down, v_up, v_down)
        for n_id = 1 : numel(computation.n)
            for target_site = 1 : 5
                %1: i 2: +x 3: +y 4: -x 5: -y
                if target_site == 1
                    [ua, va] = computation.GetUVatI(i, n_id);
                    uv_for_site_and_neigbours(1, n_id, :) = [ua(1), ua(2), va(1), va(2)];
                else
                    %we need to remap if the target site is a neighbour: target_site = 2 -> +x
                    
                    if ~isempty(system_d_wave.points{i}.neighbour{target_site - 1}) %if there is a neighbour
                        % fprintf('Neighbour found at %d for %d\n', system_d_wave.points{i}.neighbour{target_site - 1}.i, system_d_wave.points{i}.i);
                        [ub, vb] = computation.GetUVatI(system_d_wave.points{i}.neighbour{target_site - 1}.i, n_id);
                        uv_for_site_and_neigbours(target_site, n_id, :) =  [ub(1), ub(2), vb(1), vb(2)];
                    end
                end
            end  
            
        end
        system_d_wave.points{i} = system_d_wave.points{i}.computeDWave(system_d_wave, uv_for_site_and_neigbours, computation.E); %compute all the d-wave parameter
        Console.progressBar(i, numel(system_d_wave.points));
    end

%* OK until here

    for i = 2: numel(system_d_wave.points)-1
        for i_prime = i+1 :  numel(system_d_wave.points) %we fill only the upper triangle
            %because we want to enforce H_ij = H_ji , we dont want to fill the diagonal again
            % fprintf("i= %d, i_prime = %d\n", i, i_prime);
            axis = '';
            try
                if system_d_wave.points{i}.neighbour{1}.i ==  system_d_wave.points{i_prime}.i %+x
                    axis = '+x';
                end
                catch
             end
             try
                if system_d_wave.points{i}.neighbour{2}.i ==  system_d_wave.points{i_prime}.i %+x
                    axis = '+y';
                end
                catch
            end
            try
                if system_d_wave.points{i}.neighbour{3}.i ==  system_d_wave.points{i_prime}.i %+x
                    axis = '-x';
                end
                catch
            end            
            try
                if system_d_wave.points{i}.neighbour{4}.i ==  system_d_wave.points{i_prime}.i %+x
                    axis = '-y';
                end
                catch
            end
            if ~strcmp(axis, '')
                block = system_d_wave.neighbourMatrix(system_d_wave.points{i}.i, axis);
                system_d_wave.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i_prime-1) + 1: 4*(i_prime-1) + 4) = block;
                system_d_wave.hamiltonian(4*(i_prime-1) + 1: 4*(i_prime-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = block;

                % fprintf('Neighbouring matrix at %d, %d\n', i, i_prime);
                % disp(block);
            else
                % fprintf('No neighbour found at %d, %d\n', i, i_prime);
            end
        end
      
    end
    system_d_wave.check();
    % hh = heatmap(system_d_wave.hamiltonian);
    % waitfor(hh);	
    
    % diverg = zeros(numel(system_d_wave.points), numel(system_d_wave.points));
    % for i = 1: numel(system_d_wave.points)
    %     for i_prime = 1: numel(system_d_wave.points)
    %         axe = '';
    %         if (i_prime == i + 1)
    %             axe = 'x';
    %             sign = 1;
    %         elseif (i_prime == i + system_d_wave.Nx)
    %             axe = 'y';
    %             sign = 1;
    %         elseif (i_prime == i - 1)
    %             axe = 'x';
    %             sign = -1;
    %         elseif (i_prime ==  i - system_d_wave.Nx)
    %             axe = 'y';
    %             sign = -1;
    %         end
    %         if (mod(i, system_d_wave.Nx) == 0 && strcmp(axe, 'x') && sign == 1) || (mod(i-1, system_d_wave.Nx) == 0 && strcmp(axe, 'x') && sign == -1) %right edge
    %         %    fprintf('Right edge at %d, %d\n', i, i_prime);
    %             continue;
    %         end
    %         if ~strcmp(axe, '') % neighbour
    %             if sign == 1
    %                 axe1 = strcat('+', axe);
    %                 axe2 = strcat('-', axe);
    %             elseif sign == -1
    %                 axe1 = strcat('-', axe);
    %                 axe2 = strcat('+', axe);
    %             end
    %             % fprintf('Neighbouring matrix at %d, %d\n', i, i_prime);
    %             differ =  system_d_wave.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i_prime-1) + 1: 4*(i_prime-1) + 4) - system_d_wave.hamiltonian(4*(i_prime-1) + 1: 4*(i_prime-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4);
    %             disp("i = " + i + " i_prime = " + i_prime);
    %             disp(system_d_wave.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i_prime-1) + 1: 4*(i_prime-1) + 4));
    %             disp( system_d_wave.hamiltonian(4*(i_prime-1) + 1: 4*(i_prime-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4));
    %         end
    %     end
    % end
    % % hh = heatmap(diverg);
    % % waitfor(hh);
    % [m_col, id_col] = max(diverg);
    % [m, id_row] = max(m_col);
    % % disp(m_col);
   
    % fprintf('Divergence in matrices of = %.5f at i=%d, i_prime =%d\n', m, id_col(id_row), id_row);


%* Reassignment system ok

    
    total = 0;
    for j = 1: numel(system_d_wave.points)
        total = total + abs(system_d_wave.points{j}.F_d);
        debug(system_d_wave.points{j}.y, system_d_wave.points{j}.x) = system_d_wave.points{j}.F_d;
    end

    t = t+1;

    dist = GapEquationBase.computeDistance(F_d_old, GapEquationBase.generateNewCollumnDeltaOrF(system_d_wave), 1, system_d_wave.convergence_model);

    abs_dist_abs = abs(dist(:,1,1));
    abs_dist_phase = abs(dist(:,2,1));
    [x_valu, x_id] = max(abs_dist_abs);
    [y_valu, y_id] = max(abs_dist_phase);
    fprintf('convergence\n F_d ABS = %.5f %% at %d, PHASE = %.5f %% at x=%d | old norm: %d, old angle %d', ...
        x_valu, x_id ,y_valu, mod(y_id-1,30) +1, abs(F_d_old(x_id, 1)), angle(F_d_old(x_id, 1)));
end 


% fprintf('Computing currents\n');
% system_d_wave = ComputeCurrents(system_d_wave, computation); % return a 2*Nx*Ny X Nx*Ny matrix


Delta_D_phase = zeros(system_d_wave.Ny, system_d_wave.Nx, 2);
%generate a plotable matrix
for i = 1 : numel(system_d_wave.points)
    Delta_D_phase(system_d_wave.points{i}.y, system_d_wave.points{i}.x, 1) = abs(system_d_wave.points{i}.F_d);
    Delta_D_phase(system_d_wave.points{i}.y, system_d_wave.points{i}.x, 2) = angle(system_d_wave.points{i}.F_d);
end

sim_deltails = GapEquationBase.getSimulationDetails(system_d_wave);

systemMaterial = GapEquationBase.getSimMaterial();
path = strcat(".\Results\", systemMaterial);
phase_shift_folder = GapEquationBase.getPhaseShiftFolder(system_d_wave);
if system_d_wave.tilted
    tilted = "\TiltedInterface";
else
    tilted = "\StraightInterface";
end
folder = strcat(path, '\DWave', tilted, phase_shift_folder);
if not(isfolder(folder))
    mkdir(folder);
end

path_CORREL_C = strcat(folder, sim_deltails);
disp(path_CORREL_C);
writematrix(WriteHeatmap(system_d_wave, 'F_d'), strcat(path_CORREL_C, '_F_D10.dat'),'Delimiter',' ')

writematrix(trace, strcat(folder,'trace.dat'), 'Delimiter', ' ');


path_MEAN_CORREL_C = strcat(folder, "meanline_",sim_deltails);
writematrix(MeanLineMatrix(Delta_D_phase, ''), strcat(path_MEAN_CORREL_C, '_F_D10.dat'),'Delimiter',' ');

