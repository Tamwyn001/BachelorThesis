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

    result = zeros(system.Nx*system.Ny, 1);
    for j = 1: system.Nx * system.Ny
        result(j) = system.points{j}.delta;
    end
end
function result = computeDistance(delta_old, delta_new)
    result = zeros(numel(delta_old), 1);
    for i = 1: numel(delta_old)
        result(i) = abs(delta_old(i) - delta_new(i));
    end
end

treshold = 0.01; %convergence treshold
delta_old = 4; %initial old delta value


Fermi = @(E) FermiDiarac(E, System.T, System.mu);

system = System();
system = system.createLattice();
system = system.generateHam();
DELTA = zeros(system.Nx, system.Ny);
fprintf('Solving the gap equation\n');
dist = computeDistance(delta_old, generateNewCollumnDelta(system));
t = 1;
while (not(thresholdReached(dist, treshold)))
    fprintf('\nIteration %d:\n', t);
    fprintf('Diagonalising, convergence = %d\n', max(dist));
    delta_old = generateNewCollumnDelta(system);
    [chi,ener] = eig(system.hamiltonian);
    for i = 1: system.Nx * system.Ny %for each particle we search a convergence
        delta_elem_sum = 0; %initialize the sum of the delta elements
        Console.progressBar(i, system.Nx * system.Ny);
        
        %seting the value to compare with after its going to be updated
        %fprintf('diff = %d\n', delta_old-system.points{i}.delta);
        %eigenvector-, values (energy and bispinor electro u  +hole v) of H for a j

        %disp(chi) 
        %create a row energy-vector taking the diagonal
        E = diag(ener);
        
        %chi = (chi_1,..,chi_N) set of eigenvectors : as big as the matrix: to N_x
            %chi_n = (chi_n_1,..,chi_n_N )  each eigenvector has 2 components, which have also two compoennts: so 4
                %chi_n_i = (u_n_i, v_n_i) 2x1 bispinor
                    %u and v are 1x2 vector containing both a spin up and down part.
                    % Due to the form of ^c we set u_n=(u_nUP, u_nDOWN) and v_n=(v_nUP, v_nDOWN)

        %to each eigenvalue there is an eigenvector. So we get the right components of the eigenvector

        for n = 1 : numel(E) %sum over n, n numbers of eigenvectors. 
            %fprintf('[i = %d, j = %d], [i = %d, j = %d]\n', 4*(i-1) + 1, n, 4*(i-1) + 2, n);
            %fprintf('u1 = %d, u2 = %d\n', chi(4*(i-1) + 1, n), chi(4*(i-1) + 2, n));
            %disp('--');
            u_i_n = [chi(4*(i-1) + 1, n), chi(4*(i-1) + 2, n)]; %UP, DOWN
            v_i_n = [chi(4*(i-1) + 3, n), chi(4*(i-1) + 4, n)]; %UP, DOWN
            % We get the number of eigenvectors.
            %fprintf('[u_1 = %d, u_2 = %d ]\n', u_i_n(1), u_i_n(2));
            delta_elem_sum = delta_elem_sum + u_i_n(2) * conj(v_i_n(1))*Fermi(E(n)) ...
                + u_i_n(1)*conj(v_i_n(2)) * (1-Fermi(E(n))); %spin-dep variables in H are
                % defined with general spin sigma and delta with up or dow
            %disp(delta_elem_sum);
        end
        system.points{i}.delta = system.points{i}.U * delta_elem_sum;     
        %fprintf('delta = %d\n', system.points{i}.delta);
        %reinserting delta it into the hamiltonian, we rewrite the 4x4 block of the site including supercondctivity and chemical potential
    end
    %correct Hamiltonian
    for i = 1: system.Nx * system.Ny
        system.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(i-1) + 1: 4*(i-1) + 4) = system.onSiteMatrix(i);
    end
    t = t+1;
    dist = computeDistance(delta_old, generateNewCollumnDelta(system));
end 

%generate a plotable matrix
for i = 1: system.Nx * system.Ny
    DELTA(system.points{i}.y, system.points{i}.x) = abs(system.points{i}.delta);
end

% Plot the matrix as a heatmap
heatmap(DELTA,'CellLabelColor', 'None');

% Add title
details = strcat(int2str(system.Nx),'x', int2str(system.Ny));
if System.verticalPeriodicBoundary && System.horizontalPeriodicBoundary
    details = strcat(details, " with horizontal and vertical periodic boundary") ;
elseif System.verticalPeriodicBoundary
    details = strcat(details, " vertical periodic boundary");
elseif System.horizontalPeriodicBoundary
    details = strcat(details, " with horizontal periodic boundary");
else 
    details = strcat(details, " with no periodic boundary");
end
details = strcat(details, " with ");
for i = 0: (numel(System.layer)/2 - 1)
    if i > 0
        details = strcat(details, ", ");
    end
    details = strcat(details, System.layer{2*i + 2}, " layers of ", System.layer{2*i+1});
end
title(strcat("Gap equation solution of the lattice " , details));