function result = thresholdReached(dist, treshold)
    result = true;
    for i = 1: numel(dist)
        if dist(i) > treshold
            result = false;
            break;
        end
    end
end

function result = generateNewCollumnDelta(system)
    index_shift = 0;
    result = zeros(system.Nx*(system.Ny-2), 1); %subtract the sides 2 Nx elements
    for j = 1: system.Nx * system.Ny
        if ~system.points{j}.isSubjectToFixedDelta(system)
            result(j-index_shift) = system.points{j}.delta;
        else
            index_shift = index_shift + 1; %we need to come back t0 the right index
        end
    end
end

function result = computeDistance(delta_old, delta_new)
    result = zeros(numel(delta_old), 1);
    for i = 1: numel(delta_old)
        result(i) = abs(delta_old(i) - delta_new(i));
    end
end

treshold = 0.001; %convergence treshold
delta_old = 4; %initial old delta value


Fermi = @(E) FermiDiarac(E, System.T, System.mu);

system = System();
system = system.createLattice();
system = system.generateHam();
computation = Computation(system); %holds the eigenvalues and eigenvectors to access them later without passing hige matrices around

CORREL_C = zeros(system.Nx, system.Ny);
fprintf('Solving the gap equation\n');

%seting the value to compare with after its going to be updated
dist = computeDistance(delta_old, generateNewCollumnDelta(system));
t = 1;
while (not(thresholdReached(dist, treshold)))
    fprintf('\nIteration %d:', t);
    fprintf('Diagonalising');
    delta_old = generateNewCollumnDelta(system);
    %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j
    [chi, ener] = eig(system.hamiltonian);
    computation = computation.writeNewEigen(chi, ener);
    for i = 1: system.Nx * system.Ny %for each particle we search a convergence
        delta_elem_sum = 0; %initialize the sum of the delta elements
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
            delta_elem_sum = delta_elem_sum + u_i_n(2) * conj(v_i_n(1))*Fermi(computation.E(n)) ...
                + u_i_n(1)*conj(v_i_n(2)) * (1-Fermi(computation.E(n))); %spin-dep variables in H are
                % defined with general spin sigma and delta with up or dow
            %disp(delta_elem_sum);
        end
        system.points{i} = system.points{i}.updateDelta(delta_elem_sum, system); %system.points{i}.U *      
        %reinserting delta it into the hamiltonian, we rewrite the 4x4 block of the site including supercondctivity and chemical potential
        
    end
    %correct Hamiltonian
    for i = 1: system.Nx * system.Ny
        system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = system.onSiteMatrix(i);
    end
    t = t+1;
    dist = computeDistance(delta_old, generateNewCollumnDelta(system));
    fprintf('convergence = %d\n', max(dist));
end 

%generate a plotable matrix
for i = 1: system.Nx * system.Ny
    %disp(system.points{i}.delta);
    CORREL_C(system.points{i}.y, system.points{i}.x) = abs(system.points{i}.c_up_c_down);
end
%disp(computation.E);
%fprintf('Computing currents\n');
%system = ComputeCurrents(system, computation); % return a 2*Nx*Ny X Nx*Ny matrix

% Plot the matrix as a heatmap
heatmap(CORREL_C,'CellLabelColor', 'None');

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

title(strcat("Gap equation solution of the lattice " , details));
systemMaterial = "";
for i = 1 : numel(System.layer)
    systemMaterial = strcat(systemMaterial, System.layer(i));
end
path = strcat(".\Results\", systemMaterial,"\Correlation_cdagg_c_\");

if not(isfolder(path))
    mkdir(path)
end

path_CORREL_C = strcat(path, sim_deltails, ".dat");
writematrix(WriteHeatmap(system, 'correl_c_c'), path_CORREL_C,'Delimiter',' ')

path_PHASE = strcat(path, "phase_",sim_deltails, ".dat");
writematrix(WriteHeatmap(system, 'phase'), path_PHASE,'Delimiter',' ')

pathMEAN = strcat(path, "meanline_",sim_deltails, ".dat");
writematrix(MeanLineMatrix(CORREL_C), pathMEAN,'Delimiter',' ');

%pathCURRENT = strcat(path, "current_",sim_deltails, ".dat");
%writematrix(WriteVectorField(system), pathCURRENT,'Delimiter',' ');