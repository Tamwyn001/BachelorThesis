classdef System < SystemBase
    % This system describes the formalism that let pick some periodic boundary conditions
    % this is intended to diagonalize a 4NxNy x 4NxNy matrix

    methods
        function obj = System()
            %% object intialization
            obj = obj@SystemBase();
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
                            if strcmp(obj.points{i}.materialLayer, 'SC')
                                %if superconductive neigbours interactions
                            elseif strcmp(obj.points{i}.materialLayer,'AM')
                                to_add = to_add + System.altermagnetMatrix(axe);
                            end
                        
                            to_add = to_add + System.hopping_t_ij(); %part of the non-interacting hamiltonian
                            %futher interaction processes can be added here

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
            matrix = System.chemicalMatrix(System.mu) + System.superconductingMatrix(obj.points{i}.delta); %U takes care of masking this value for the material
        end

    end 
    methods (Static)
        
        function matrix=altermagnetMatrix(axe)
            m_sigma = System.getMSigma(axe);
            matrix = [m_sigma, zeros(2); zeros(2), zeros(2)];
        end
        function matrix = hopping_t_ij()
            matrix = [System.t_ij *eye(2), zeros(2); zeros(2), -conj(System.t_ij) * eye(2)];
        end
        function matrix = superconductingMatrix(delta)
            matrix = [zeros(2), (delta * (-1i)) * PauliMatrix.sigmaY; ...
                conj(delta) * (1i) * PauliMatrix.sigmaY, zeros(2)];
        end
        function matrix= chemicalMatrix(mu)
            matrix = mu * [eye(2), zeros(2); zeros(2), -eye(2)];
        end
    end
end