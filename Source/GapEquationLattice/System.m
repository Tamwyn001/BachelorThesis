classdef System < SystemBase
    % This system describes the formalism that let pick some periodic boundary conditions
    % this is intended to diagonalize a 4NxNy x 4NxNy matrix
    properties
        tilted
        DWavePurpose
    end
    properties (Constant)
        t_ij = 1.0;
    end
    methods
        function obj = System(DWavePurpose)
            %% object intialization
            obj = obj@SystemBase();
            obj.points = cell(obj.Nx * obj.Ny ,1);

            if nargin == 0
                obj.DWavePurpose = false;
            else
                obj.DWavePurpose = DWavePurpose;
            end
            obj.convergence_model = "abs_angle";
        end

        function obj = createLattice(obj, tilted)

            obj = createLattice@SystemBase(obj);
            obj.tilted = tilted;
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
                    if strcmp(obj.points{i}.materialLayer,'V')
                        continue;
                    end
                    if i == j %we are on the diagonal. We find the superconducting and chemical potential terms
                        obj.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(j-1) + 1: 4*(j-1) + 4) = obj.onSiteMatrix(i);

                    else % (~obj.points{i}.foundAllNeighbours()) %if not all the 4 neibours were found + on i j
                        if strcmp(obj.points{j}.materialLayer,'V')
                            continue;
                        end
                        [are_neigh, axe] = Neighbours(obj.points{i}, obj.points{j}, obj); %returns the interaction as well

                        if are_neigh
                            obj.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(j-1) + 1: 4*(j-1) + 4) = obj.neighbourMatrix(i, axe);
                                
                        end
                        %we are not neighbours, no contribution of the c operators
                        % already zeros
                    end
                end
                Console.progressBar(i, obj.Nx * obj.Ny);
            end
            % obj.check();
        end
        function check(obj)
            for i = 1: obj.Nx * obj.Ny
                for j = i : obj.Nx * obj.Ny
                    for a = 1:4
                        for b = 1:4
                            if ~obj.hamiltonian(4*(j-1) + a, 4*(i-1) + b) == conj(obj.hamiltonian(4*(i-1) + b, 4*(j-1) + a))
                                fprintf('Hamiltonian is not Hermitian at %d, %d\n', i, j);
                                disp(obj.hamiltonian(4*(j-1) + 1: 4*(j-1) + 4, 4*(i-1) + 1:  4*(i-1) + 4));
                                disp(obj.hamiltonian(4*(i-1) + 1: 4*(i-1) + 4, 4*(j-1) + 1:  4*(j-1) + 4));
                            end
                        end
                    end

                end
            end
        end
        function matrix = onSiteMatrix(obj, i) %site i
            matrix = System.chemicalMatrix(System.mu);
            if strcmp(obj.points{i}.materialLayer, 'SC') && (~(obj.DWavePurpose))
                matrix = matrix + System.superconductingMatrix(obj.points{i}.delta);
            end
        end
        function matrix = neighbourMatrix(obj, i, axe)
            matrix = zeros(4);
            
            if strcmp(axe, '+x')
                nei_id = 1;
            elseif strcmp(axe, '-x')
                nei_id = 3;
            elseif strcmp(axe, '+y')
                nei_id = 2;
            elseif strcmp(axe, '-y')
                nei_id = 4;
            else
                assert(false, 'axe not found');
            end
            
            j = obj.points{i}.neighbour{nei_id}.i;
            if strcmp(obj.points{i}.materialLayer,'AM') && strcmp(obj.points{j}.materialLayer,'AM')
                matrix = matrix + System.altermagnetMatrix(axe);

            elseif strcmp(obj.points{i}.materialLayer,'FM') && strcmp(obj.points{j}.materialLayer,'FM')
                matrix = matrix + System.ferromagnetMatrix();
    
            elseif strcmp(obj.points{i}.materialLayer,'SC') && strcmp(obj.points{j}.materialLayer,'SC') && obj.DWavePurpose
                matrix = matrix + System.dWaveMatrix(axe, obj.points{i});
            end

            matrix = matrix + System.hopping_t_ij(); %part of the non-interacting hamiltonian
                %futher interaction processes can be added here 
        end
    end 
    methods (Static)
        
        function matrix=altermagnetMatrix(axe)
            m_sigma = SystemBase.getMSigma(axe);
            matrix =  -1.* [m_sigma, zeros(2); zeros(2), -1.* transpose(m_sigma)];
        end
        function matrix=ferromagnetMatrix() 
            m_sigma = SystemBase.m .* PauliMatrix.sigmaZ;
            matrix = -1.* [m_sigma, zeros(2); zeros(2), -1.*transpose(m_sigma)];
        end
        function matrix = hopping_t_ij()
            matrix = -1.* [System.t_ij *eye(2), zeros(2); zeros(2), -conj(System.t_ij) * eye(2)];
        end
        function matrix = superconductingMatrix(delta)
        matrix = -1.* [zeros(2), (delta * (-1i)) * PauliMatrix.sigmaY; ...
                conj(delta) * (1i) * PauliMatrix.sigmaY, zeros(2)];
        end
        function matrix= chemicalMatrix(mu)
            matrix = -1. * mu .* [eye(2), zeros(2); zeros(2), -eye(2)];
        end
        function matrix = dWaveMatrix(axis, point)
            F = 0;
            if strcmp(axis, '+x')
                F = point.F_x(1);
            elseif strcmp(axis, '-x')
                F = point.F_x(2);
            elseif strcmp(axis, '+y')
                F = point.F_y(1);
            elseif strcmp(axis, '-y')
                F = point.F_y(2);
            else
                assert(false, 'axe not found');
            end
            % if point.i == 250
            %     fprintf('%s, has %f ', axis, F);
            % end
            matrix = -1 .* [zeros(2), -1i * F .* PauliMatrix.sigmaY; ...
                1i * conj(F) .* PauliMatrix.sigmaY, zeros(2)];
        end
    end
end