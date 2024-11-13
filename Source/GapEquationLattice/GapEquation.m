function result = thresholdReached(dist, treshold)
    result = true;
    for i = 1: size(dist,1)
        if dist(i,1) > treshold && dist(i,1) < 0
            result = false;
            return;
        end
        if dist(i,2) > treshold && dist(i,2) < 0
            result = false;
            return;
        end
    end
end

function result = generateNewCollumnDelta(system)
    index_shift = 0;
    if system.fixedBoundaryDelta
        result = zeros(system.Nx*(system.Ny-2), 1); %subtract the sides 2 Nx elements
    else
        result = zeros(system.Nx*system.Ny, 1);
    end
    for j = 1: system.Nx * system.Ny
        if ~system.points{j}.isSubjectToFixedDelta(system)
            result(j-index_shift) = system.points{j}.delta;
        else
            index_shift = index_shift + 1; %we need to come back t0 the right index
        end
    end
end

function result = computeDistance(delta_old, delta_new)  
    length = size(delta_old, 1);
    result = zeros(length, 2);
    for i = 1: length
        result(i,1) = (real(delta_new(i)) - real(delta_old(i))) / real(delta_old(i)) *100.0; %relative error from the old to new step
        result(i,2) = (imag(delta_new(i)) - imag(delta_old(i))) / imag(delta_old(i)) *100.0;
    end
end

function loop_on = canLoop(terminated, dist, treshold)
    loop_on = true;
    if thresholdReached(dist, treshold) 
        loop_on = false;
        return;
    elseif terminated
        loop_on = false;
        return;
    end
end

treshold = 0.75; %convergence treshold in percentage of change


Fermi = @(E) FermiDiarac(E, System.T, System.mu);

system = System();
system = system.createLattice();
system = system.generateHam();
computation = Computation(system); %holds the eigenvalues and eigenvectors to access them later without passing hige matrices around

CORREL_C = zeros(system.Ny, system.Nx);
fprintf('Solving the gap equation\n');

if system.fixedBoundaryDelta
    delta_old = 4.0*ones(system.Nx*(system.Ny-2), 1); %subtract the sides 2 Nx elements
else
    delta_old = 4.0*ones(system.Nx*system.Ny, 1);
end
%seting the value to compare with after its going to be updated
dist = computeDistance(delta_old, generateNewCollumnDelta(system));

t = 1;
CORREL_C_trace = zeros(10,system.Ny, system.Nx);
% for i = 1: system.Nx * system.Ny
%     disp('BEGIN');
%     disp(system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4));
% end
while (canLoop(false, dist, treshold)) 
    fprintf('\nIteration %d:', t);
    
    fprintf('Diagonalising');
    delta_old = generateNewCollumnDelta(system);
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

        for n = numel(computation.E)/2 +1 : numel(computation.E) %sum over n, n numbers of eigenvectors with POSITIVE energies.
            [u_i_n, v_i_n] = GetUVatI(computation, i, n);
            % We get the number of eigenvectors.
            c_up_c_down = c_up_c_down + conj(v_i_n(1)) * u_i_n(2) *  Fermi(computation.E(n)) ...
                + u_i_n(1) * conj(v_i_n(2)) * (1-Fermi(computation.E(n))); %spin-dep variables in H are
                % defined with general spin sigma and delta with up or dow
        end
        system.points{i} = system.points{i}.updateDelta(c_up_c_down, system); %system.points{i}.U *      


    end
    
    %correct Hamiltonian
    for i = 1: system.Nx * system.Ny
        %disp(system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4));
        system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = system.onSiteMatrix(i);
        %disp('After');
        %disp(system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4));
    end

    t = t+1;
    dist = computeDistance(delta_old, generateNewCollumnDelta(system));
    [x_valu, x_id] = max(dist(:,1));
    [y_valu, y_id] = max(dist(:,2));
    fprintf('convergence  RE = %.2f %% at %d, IM = %.2f %% at %d : re:%d, im: %d\n', x_valu, x_id, y_valu, y_id, real(system.points{x_id}.delta),  imag(system.points{x_id}.delta));
    %fprintf('Debug at location 62 RE: %d, %d%% ; IM: %d, %d%%', real(system.points{x_id}.delta), dist(62, 1), imag(system.points{x_id}.delta), dist(62, 2));
end 

%generate a plotable matrix
for i = 1: system.Nx * system.Ny
    %disp(system.points{i}.delta);
    CORREL_C(system.points{i}.y, system.points{i}.x) = abs(system.points{i}.c_up_c_down);
end
%disp(computation.E);
fprintf('Computing currents\n');
system = ComputeCurrents(system, computation); % return a 2*Nx*Ny X Nx*Ny matrix

% Plot the matrix as a heatmap
% heatmap(CORREL_C,'CellLabelColor', 'None');

% Add title
details = strcat(int2str(system.Nx),'x', int2str(system.Ny));
sim_deltails = details;
if System.verticalPeriodicBoundary && System.horizontalPeriodicBoundary
    details = strcat(details, " with horizontal and vertical periodic boundary") ;
    sim_deltails = strcat(sim_deltails, "VertHorizBC");
elseif System.verticalPeriodicBoundary
    details = strcat(details, " vertical periodic boundary");
    sim_deltails = strcat(sim_deltails, "VertBC");
elseif System.horizontalPeriodicBoundary
    details = strcat(details, " with horizontal periodic boundary");
    sim_deltails = strcat(sim_deltails, "HorizBC");
else 
    details = strcat(details, " with no periodic boundary");
    sim_deltails = strcat(sim_deltails, "NoBC");
end
details = strcat(details, " with ");
for i = 0: (numel(System.layer)/2 - 1)
    if i > 0
        details = strcat(details, ", ");
    end
    details = strcat(details, System.layer{2*i + 2}, " layers of ", System.layer{2*i+1});
end

% title(strcat("Gap equation solution of the lattice " , details));
systemMaterial = "";
for i = 1 : numel(System.layer)
    systemMaterial = strcat(systemMaterial, System.layer(i));
end
path = strcat(".\Results\", systemMaterial);


phase_shift_folder = "";
    
if System.fixedBoundaryDelta || System.fixedBoundaryDeltaArg
    phase_shift = round((system.phi_2 - system.phi_1) * (180/pi));
    phase_shift_folder = ''; % strcat("\Phase", num2str(phase_shift), "deg\");
end

phase_shift_folder = strcat(phase_shift_folder,"diffMU\", num2str(System.mu),"\", "LinearPhaseGradient\", num2str(System.phi_1),"\");
if not(isfolder(strcat(path, phase_shift_folder)))
    mkdir(strcat(path, phase_shift_folder));
end



path_CORREL_C = strcat(path, phase_shift_folder, sim_deltails, ".dat");
writematrix(WriteHeatmap(system, 'correl_c_c'), path_CORREL_C,'Delimiter',' ')

path_PHASE = strcat(path, phase_shift_folder, "phase_",sim_deltails, ".dat");
writematrix(WriteHeatmap(system, 'phase'), path_PHASE,'Delimiter',' ')

path_CONTINUITY = strcat(path, phase_shift_folder, "continuity_",sim_deltails, ".dat");
writematrix(WriteHeatmap(system, 'continuity'), path_CONTINUITY,'Delimiter',' ')

pathMEAN = strcat(path, phase_shift_folder, "meanline_",sim_deltails, ".dat");
writematrix(MeanLineMatrix(CORREL_C, ''), pathMEAN,'Delimiter',' ');

pathMEAN_RE = strcat(path, phase_shift_folder, "meanline_RE_",sim_deltails, ".dat");
writematrix(MeanLineMatrix(CORREL_C, 'real'), pathMEAN_RE,'Delimiter',' ');

pathMEAN_IM = strcat(path, phase_shift_folder, "meanline_IM_",sim_deltails, ".dat");
writematrix(MeanLineMatrix(CORREL_C,'imag'), pathMEAN_IM,'Delimiter',' ');

pathCURRENT = strcat(path, phase_shift_folder, "current_",sim_deltails, ".dat");
writematrix(WriteVectorField(system), pathCURRENT,'Delimiter',' ');

% step_correl = zeros(system.Ny, system.Nx);
% for steps = 1:size(CORREL_C_trace,1)
%     pathMEAN_trace = strcat(path, phase_shift_folder, "meanline", sim_deltails, "_step_", num2str(steps),".dat");
%     step_correl(:,:) = CORREL_C_trace(steps,:,:);
%     writematrix(MeanLineMatrix(step_correl), pathMEAN_trace,'Delimiter',' ');
% end
disp(sprintf('Saved at: %s', strcat(path, phase_shift_folder)));
