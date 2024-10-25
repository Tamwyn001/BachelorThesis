classdef System
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties (Constant)
        verticalPeriodicBoundary = true;
        horizontalPeriodicBoundary = false;

        guessDelta = 0.002;
        %makes only sense when no horiz. periodic boundary conditon is applied
        fixedBoundaryDelta = true;
        phi_1 = pi/6; %phase of the superconducting gap on the left side
        phi_2 = pi/6 + ( (27+90) * pi/180); %phase of the superconducting gap on the right side, phase shift of 25°
        layer =  ["SC",30];%["SC", 13, "AM", 5 "SC", 13]; %["SC", 10, "AM", 10] %superconducting and altermgnet layer separated verticaly ["SC", 10, "AM", 4, "SC", 10]
        %the hopping amplitude, t =1 normalizes energies
        t_ij = 1;  

        T = 0.001; %K  muss no be to targe in order to stay under the critical temperature
        mu = 5; %eV
        m = 1; %hopping
        m_matrix = [[0,0, System.m], [0,0, -System.m]]; %contributions factor on the pauli matrixies. the submatrices...
        %  are hopping in x and y directions9
        Ny = 15; 
    end
    properties
        Nx;
        points;
        hamiltonian;
        fixedDelta;
    end

    methods
        function obj = System()
            %UNTITLED5 Construct an instance of this claÄ2ss
            %   Detailed explanation goes here
            size = 0;
            for i = 1: numel(System.layer)/2
                size = size + str2num(System.layer(2*i));
            end
            obj.Nx = size;
             %we preallocate the array to gain in speed
            obj.points = cell(obj.Nx * obj.Ny ,1);
            obj.fixedDelta = [abs(obj.guessDelta)*exp(1i * obj.phi_1), abs(obj.guessDelta)*exp(1i * obj.phi_2)];

            fprintf('System created with specs:\n');
            fprintf('   Nx = %d, Ny = %d\n', obj.Nx, obj.Ny);
            fprintf('   T = %d, mu = %d\n', obj.T, obj.mu);
            fprintf('   vertical = %d, horizontal = %d\n', obj.verticalPeriodicBoundary, obj.horizontalPeriodicBoundary);
        end
        function obj = createLattice(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            for i = 1: obj.Nx * obj.Ny
                obj.points{i} = LatticePoint(obj, i); % {i} is the i-th element of the cell array, not a cell but the stored object
            end
            for i = 1: numel(obj.points)
                obj.points{i} = obj.points{i}.findNeighbours(obj);
            end
        end

        function obj = generateHam(obj)
            fprintf('Generating Hamiltonian\n');
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
            matrix = System.chemicalMatrix(System.mu);
            if strcmp(obj.points{i}.materialLayer, 'SC')
                matrix = matrix + System.superconductingMatrix(obj.points{i}.delta);
            end
        end

    end 
    methods (Static)
        function m_sigma = getMSigma(axe)
            if strcmp(axe, 'x')    
                lookup = 0; %the lookup changes to fit an x or y hopping to find the good vector in the m_matrix
            elseif strcmp(axe, 'y')
                lookup = 3;
            else
                disp("NO AXE!")
            end
            m_sigma = System.m_matrix(1 + lookup) * PauliMatrix.sigmaX ...
                + System.m_matrix(2 + lookup) * PauliMatrix.sigmaY ...
                + System.m_matrix(3 + lookup) * PauliMatrix.sigmaZ;
        end
        function out = getMSigmaElem(axe, spin1, spin2)
            out = System.getMSigma(axe);
            out = out(spin1, spin2);
        end
        function matrix=altermagnetMatrix(axe)
            m_sigma = System.getMSigma(axe);
            matrix = [m_sigma, zeros(2); zeros(2), zeros(2)];
        end
        function matrix = hopping_t_ij()
            matrix = [System.t_ij *eye(2), zeros(2); zeros(2), -conj(System.t_ij) * eye(2)];
        end
        function matrix = superconductingMatrix(delta)
            %UNTITLED5 Summary of this method goes here
            %   Detailed explanation goes here

            matrix = [zeros(2), (delta * (-1i)) .* PauliMatrix.sigmaY; ...
                conj(delta)*(1i).*PauliMatrix.sigmaY, zeros(2)];
        end
        function matrix= chemicalMatrix(mu)
            matrix = mu * [eye(2), zeros(2); zeros(2), -eye(2)];
        end
        function type = sampleTypeAt(x)
            if x <= str2num(System.layer(2))
                type = System.layer(1);
            elseif x <= str2num(System.layer(2)) + str2num(System.layer(4))
                type = System.layer(3);
            elseif x <= str2num(System.layer(2)) + str2num(System.layer(4)) + str2num(System.layer(6))
                type = System.layer(5);
            end
        end
    end
end