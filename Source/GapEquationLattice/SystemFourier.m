classdef SystemFourier < SystemBase
    % This system describes the formalism that has vertical periodic boundary conditions
    % therfore we can use a fourier transformation in y resulting in a Ny times a 4Nx x 4Nx matrix

    %!always VERTICAL PERIODIC BOUNDARY CONDITIONS TO TRUE and HORIZONTAL TO FALSE :)
    properties (Constant)
        t_SC = 1;
        t_AM = 1;
        t_transition = 1;
        V = 1;	
    end
    properties
        k

    end
    methods
        function obj = SystemFourier()
            %% object intialization
            obj = obj@SystemBase();
            assert(SystemBase.verticalPeriodicBoundary,'Please set verticalPeriodicBoundary to true to use the fourier formalism.');
            obj.points = cell(obj.Nx, 1);
            tot_k = SystemBase.Ny;
            obj.k = zeros(tot_k, 1);
            % we need n from [-Ny/2 to Ny/2).
            for i = 1:tot_k 
                n = -1 * SystemBase.Ny / 2 + i -1; % i starts at 1. 
                obj.k(i) = 2 * pi * n / SystemBase.Ny;
            end
        end

        function obj = generateHam(obj, first_call)
            if first_call
                obj = generateHam@SystemBase(obj);

                % have  obj.Ny matricies of size 2obj.Nx * 2obj.Nx
                obj.hamiltonian = zeros(2 * obj.Nx, 2 *obj.Nx, obj.Ny); % stores (x,x',k): k array of 2Nx x 2Nx matrices
            end
            Console.progressBar(0, obj.Nx * obj.Ny);

            for k_id =1 : numel(obj.k)
                k_local = obj.k(k_id);
                for x = 1 : obj.Nx
                    for x_prime = 1 : obj.Nx
                        if x == x_prime
                            obj.hamiltonian(2*(x - 1) + 1 : 2*(x - 1) + 2 ,...
                                 2*(x_prime - 1) + 1 : 2*(x_prime - 1) + 2, k_id ) = obj.onSiteMatrix(x, k_local);
                        else
                            if x == x_prime + 1 && x == x_prime - 1 %here the neighbouring system is waaay easier bc one axis
                                to_add = obj.hopping_t_ij_Interac(x, x_prime);
                                to_add = to_add + obj.superconductingMatrix(x, x_prime, k_local);

                                obj.hamiltonian(2*(x - 1) + 1 : 2*(x - 1) + 2 , ...
                                    2*(x_prime - 1) + 1 : 2*(x_prime - 1) + 2, k_id ) = to_add;
                            end
                        end
                    end
                end
                Console.progressBar((k_local-1) * x + x, obj.Nx * obj.Ny);
            end 
        end

        function obj = createLattice(obj)
            
            obj = createLattice@SystemBase(obj);

            %this requieres a Nx*Ny lattice system
            for i = 1: obj.Nx
                obj.points{i} = LatticePoint(obj, i); % {i} is the i-th element of the cell array, not a cell but the stored object
            end
            for i = 1: numel(obj.points)
                obj.points{i} = obj.points{i}.findNeighbours(obj);
            end
        end

        function matrix = onSiteMatrix(obj, x, k_local) %site i
            matrix = SystemFourier.chemicalMatrix(SystemBase.mu) ...
            + obj.hopping_t_ij_OnSite(x, k_local)...
            + obj.superconductingMatrix(x, x, k_local); %U takes care of masking this value for the material
        end
        
        function matrix = hopping_t_ij_OnSite(obj, x, k_local)
            matrix = -obj.getTAtX(x,x) * 2 * cos(k_local) * eye(2); %In the diag, first 1 is spin up and second 1 ist spin down.
        end
        
        function matrix = hopping_t_ij_Interac(obj, x, x_prime)
            matrix = -obj.getTAtX(x,x_prime) * eye(2); %In the diag, first 1 is spin up and second 1 ist spin down.
        end

        function t = getTAtX(obj, x,x_prime )
            if strcmp(obj.points{x}.materialLayer,'SC') && strcmp(obj.points{x_prime}.materialLayer,'SC')
                t = SystemFourier.t_SC;
            elseif  strcmp(obj.points{x}.materialLayer,'AM') && strcmp(obj.points{x_prime}.materialLayer,'AM')
                t = SystemFourier.t_AM;
            else
                t = SystemFourier.t_transition;
            end
        end
        function matrix = superconductingMatrix(obj, x, x_prime, k_local)
            f_ijk = 0;
            V_ij = 0;
            if strcmp(obj.points{x}.materialLayer,'SC') && strcmp(obj.points{x_prime}.materialLayer,'SC')
                V_ij = SystemFourier.V;
            end

            if x == x_prime
                f_ijk = obj.points{x}.F_y(1) * exp(1i* k_local) + obj.points{x}.F_y(2) * exp(-1i* k_local);

            elseif x + 1 == x_prime
                f_ijk = obj.points{x}.F_x(1);

            elseif x - 1 == x_prime
                f_ijk =  obj.points{x}.F_x(2);
            end
            f_ijk = V_ij * f_ijk;

            matrix = [0, f_ijk ; conj(f_ijk), 0];
        end
    

    end 
    

    methods (Static)
        function matrix= chemicalMatrix(mu)
            matrix = -mu * eye(2);
        end

    end
end