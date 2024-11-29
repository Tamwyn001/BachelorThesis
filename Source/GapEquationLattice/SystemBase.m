classdef SystemBase
    %Sotres the basic properties of and methodes the physical system

    properties (Constant)
        verticalPeriodicBoundary = false;
        horizontalPeriodicBoundary = false;

        guessDelta = 2 * 0.02937; %for 1.75: 0.0650, for the 2.75: 0.02937, for 3.75:  0.003723
        %makes only sense when no horiz. periodic boundary conditon is applied
        fixedBoundaryDeltaNorm = false;
        fixedBoundaryDeltaArg = true;
        phi_1 = -1.0*pi/3.0; %phase of the superconducting gap on the left side
        phi_2 = -1.0*pi/3.0 + (117*pi/180); %phase of the superconducting gap on the right side, phase shift of 117°
        layer =  ["SC", 30]; %superconducting and altermgnet layer separated verticaly ["SC", 10, "AM", 4, "SC", 10]
        %the hopping amplitude, t =1 normalizes energies


        T = 0.001; %K  
        %  no be to targe in order to stay under the critical temperature
        mu = -2.75; % * t_ij  -3.75
        m = 1; %hopping
        m_matrix = [[0,0, SystemBase.m], [0,0, -SystemBase.m]]; %contributions factor on the pauli matrixies. the submatrices...
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
            
            if SystemBase.fixedBoundaryDeltaArg
                obj.fixedDelta = [abs(obj.guessDelta)*exp(1i * obj.phi_1), abs(obj.guessDelta)*exp(1i * obj.phi_2)];
            elseif SystemBase.fixedBoundaryDeltaNorm
                obj.fixedDelta = [obj.guessDelta, obj.guessDelta];
            end

            fprintf('System created with specs:\n');
            fprintf('   Nx = %d, Ny = %d\n', obj.Nx, obj.Ny);
            fprintf('   T = %d, mu = %d\n', obj.T, obj.mu);
            fprintf('   vertical = %d, horizontal = %d\n', obj.verticalPeriodicBoundary, obj.horizontalPeriodicBoundary);
        end

        function obj = createLattice(obj)
        end

        function obj = generateHam(obj)
            fprintf('Generating Hamiltonian\n');
        end

        function i = xy_to_i(obj, x, y)
            % Convert x, y coordinates to i index
            i = (y-1)*obj.Nx + x;
        end

        function [x, y] = i_to_xy(obj,i)
            % Convert i index to x, y coordinates
            x = mod(i-1, obj.Nx) + 1;
            y = floor((i-1)/obj.Nx) + 1;
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