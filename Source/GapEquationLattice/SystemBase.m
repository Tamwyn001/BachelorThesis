classdef SystemBase
    %Sotres the basic properties of and methodes the physical system

    properties (Constant)
        verticalPeriodicBoundary = false;
        horizontalPeriodicBoundary = false;

        guessDelta = 2* 0.3; % for detla or to scale the F yx+-
        %makes only sense when no horiz. periodic boundary conditon is applied
        fixedBoundaryDeltaNorm = false;
        fixedBoundaryDeltaArg = false;
        phi_1 = 1.0*pi/3.0; %phase of the superconducting gap on the left side
        phi_2 = 1.0*pi/3.0;% + (117*pi/180); %phase of the superconducting gap on the right side, phase shift of 117°
        layer = ["SC", 30];% ["SC", 12, "AM", 6, "SC",12];superconducting and altermgnet layer separated verticaly ["SC", 10, "AM", 4, "SC", 10]
        %the hopping amplitude, t =1 normalizes energies


        T = 0.001; %K  
        %  no be to targe in order to stay under the critical temperature
        mu = -1.75; 
        m = 0.8; %hopping
        m_matrix = [[0,0, SystemBase.m], [0,0, -SystemBase.m]]; %contributions factor on the pauli matrixies. the submatrices...
        %  are hopping in x and y directions
        Ny = 15; 
    end
    properties
        convergence_model; %abs_angle if fourier , or re_im
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
            
            for i = 1: numel(obj.layer)/2
                size = size + str2num(obj.layer(2*i));
            end
            obj.Nx = size;
             %we preallocate the array to gain in speed
            
            if obj.fixedBoundaryDeltaArg
                obj.fixedDelta = [abs(obj.guessDelta)*exp(1i * obj.phi_1), abs(obj.guessDelta)*exp(1i * obj.phi_2)];
            elseif obj.fixedBoundaryDeltaNorm
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
            if strcmp(axe, '+x') || strcmp(axe, '-x')|| strcmp(axe, 'x')
                lookup = 0; %the lookup changes to fit an x or y hopping to find the good vector in the m_matrix
            elseif strcmp(axe, '+y') || strcmp(axe, '-y') || strcmp(axe, 'y')
                lookup = 3;
            else
                disp("NO AXE!")
            end
            m_sigma = SystemBase.m_matrix(1 + lookup) * PauliMatrix.sigmaX ...
                + SystemBase.m_matrix(2 + lookup) * PauliMatrix.sigmaY ...
                + SystemBase.m_matrix(3 + lookup) * PauliMatrix.sigmaZ;
        end
        function out = getMSigmaElem(axe, spin1, spin2)
            M = SystemBase.getMSigma(axe);
            out = M(spin1, spin2);
        end
        
        function type = sampleTypeAt(x, y, tilted, num_layers)
            if nargin == 4
                if tilted
                    if num_layers ~= 1
                        range = [0, 0];
                        dist = y - ceil(SystemBase.Ny / 2);
                        range(1) = str2num(SystemBase.layer(2)) + dist;
                        if num_layers == 2
                            if x <= range(1)
                                type = SystemBase.layer(1);
                            else
                                type = SystemBase.layer(3);
                            end
                        elseif num_layers == 3
                            range(2) = range(1) + str2num(SystemBase.layer(4));
                            if x <= range(1)
                                %disp("1");
                                type = SystemBase.layer(1);
                            elseif x <= range(2)
                                type = SystemBase.layer(3);
                                %disp("2");
                            else
                                type = SystemBase.layer(5);
                            end
                        end
                        return;
                    end
                end
            end
            if x <= str2num(SystemBase.layer(2))
                type = SystemBase.layer(1);
            elseif x <= str2num(SystemBase.layer(2)) + str2num(SystemBase.layer(4))
                type = SystemBase.layer(3);
            elseif x <= str2num(SystemBase.layer(2)) + str2num(SystemBase.layer(4)) + str2num(SystemBase.layer(6))
                type = SystemBase.layer(5);
            end
            
        end
    end
end