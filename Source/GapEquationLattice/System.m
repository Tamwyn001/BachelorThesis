classdef System < SystemBase
    % This system describes the formalism that let pick some periodic boundary conditions
    % this is intended to diagonalize a 4NxNy x 4NxNy matrix

    properties (Constant)
        t_ij = 1;
    end
    methods
        function obj = System()
            %% object intialization
            obj = obj@SystemBase();
            obj.points = cell(obj.Nx * obj.Ny ,1);
        end

        function obj = createLattice(obj)
            
            obj = createLattice@SystemBase(obj);

            %this requieres a Nx*Ny lattice system
            for i = 1: obj.Nx * obj.Ny
                obj.points{i} = LatticePoint(obj, i); % {i} is the i-th element of the cell array, not a cell but the stored object
            end
            for i = 1: numel(obj.points)
                obj.points{i} = obj.points{i}.findNeighbours(obj);
            end
        end
        
        function obj = generateHam(obj)
            obj = generateHam@SystemBase(obj);

            obj.hamiltonian = zeros(4 * obj.Nx * obj.Ny, 4 *obj.Nx * obj.Ny); % have obj.Nx * obj.Ny matrices of the size 4x4
            Console.progressBar(0, obj.Nx * obj.Ny);
            for i = 1 : obj.Nx * obj.Ny
                for j = 1 : obj.Nx * obj.Ny
                    if i == j %we are on the diagonal. We find the superconducting and chemical potential terms
                        obj.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(j-1) + 1: 4*(j-1) + 4) = obj.onSiteMatrix(i);

                    else %we consider the neighbours, that possbile are bc of the periodic boundary
                        [are_neigh, axe] = Neighbours(obj.points{i}, obj.points{j}, obj); %returns the interaction as well
                        if are_neigh
                            to_add = zeros(4);
                            if strcmp(obj.points{i}.materialLayer,'AM')
                                to_add = to_add + System.altermagnetMatrix(axe);
                            else 
                                to_add = to_add + System.hopping_t_ij(); %part of the non-interacting hamiltonian
                                %futher interaction processes can be added here
                            end
                        
                           

                            obj.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(j-1) + 1: 4*(j-1) + 4) = to_add;
                                
                        end
                        %we are not neighbours, no contribution of the c operators
                        % already zeros
                    end
                end
                Console.progressBar(i, obj.Nx * obj.Ny);
            end
        end

        function matrix = onSiteMatrix(obj, i) %site i
            matrix = 1*System.chemicalMatrix(System.mu);
            if strcmp(obj.points{i}.materialLayer, 'SC')
                matrix = matrix + System.superconductingMatrix(obj.points{i}.delta);
            end
        end

    end 
    methods (Static)
        
        function matrix=altermagnetMatrix(axe)
            m_sigma = System.getMS2igma(axe);
            matrix = -0.5.* [m_sigma, zeros(2); zeros(2), -1 .* m_sigma];
        end
        function matrix = hopping_t_ij()
            matrix = -1 .* [System.t_ij *eye(2), zeros(2); zeros(2), -conj(System.t_ij) * eye(2)];
        end
        function matrix = superconductingMatrix(delta)
            matrix = -1 .* [zeros(2), (delta * (-1i)) * PauliMatrix.sigmaY; ...
                conj(delta) * (1i) * PauliMatrix.sigmaY, zeros(2)];
        end
        function matrix= chemicalMatrix(mu)
            matrix = -1*mu .* [eye(2), zeros(2); zeros(2), -eye(2)];
        end
    end
end