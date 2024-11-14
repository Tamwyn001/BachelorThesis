classdef SystemBase
    %Sotres the basic properties of and methodes the physical system

    properties (Constant)
        verticalPeriodicBoundary = true;
        horizontalPeriodicBoundary = false;

        guessDelta = 0.001;
        %makes only sense when no horiz. periodic boundary conditon is applied
        fixedBoundaryDelta = false;
        fixedBoundaryDeltaArg = true;
        phi_1 = 2.0*pi/6.0; %phase of the superconducting gap on the left side
        phi_2 = 2.0*pi/6.0 + ( (117) * pi/180.0); %phase of the superconducting gap on the right side, phase shift of 25°
        layer =  ["SC", 30];%["SC", 13, "M", 5 "SC", 13]; %["SC", 10, "AM", 10] %superconducting and altermgnet layer separated verticaly ["SC", 10, "AM", 4, "SC", 10]
        %the hopping amplitude, t =1 normalizes energies
        t_ij = 1;  

        T = 0.001; %K  
        %  no be to targe in order to stay under the critical temperature
        mu = 0.75; % * t_ij  -3.75
        m = 1; %hopping
        m_matrix = [[0,0, System.m], [0,0, -System.m]]; %contributions factor on the pauli matrixies. the submatrices...
        %  are hopping in x and y directions
        Ny = 15; 
    end
    properties
        Nx;
        points;
        hamiltonian;
        fixedDelta;
    end

    methods
        function obj = SystemBase()
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