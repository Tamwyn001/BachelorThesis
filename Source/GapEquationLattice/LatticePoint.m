classdef LatticePoint
    % Class to store a lattice point and classify it
    
    properties
        i % i-coordinate in the lattice i system
        x % x-coordinate
        y % y-coordinate in the lattice x y system
        delta %superconducting gap of the site
        type % type of lattice point
        materialLayer % material of the lattice point
        U %addition parameter for the gap equation
        system
    end
    properties (Constant)
        
    end
    
    methods
        % Constructor method to initialize coordinates
        function obj = LatticePoint(system, x, y)
            obj.system = system;
            if nargin == 3
                obj.x = x;
                obj.y = y;
                obj.i = obj.xy_to_i(x, y);
                obj.materialLayer = System.sampleTypeAt(obj.x);

            elseif nargin == 2
                obj.i = x; %the input is the index i
                [obj.x ,obj.y] = obj.i_to_xy(obj.i);
                obj.materialLayer = System.sampleTypeAt(obj.x);
            end

            obj = obj.classifyPoint();
            if strcmp(obj.materialLayer,'SC')
                obj.U = 1;
            else
                obj.U = 0;
            end
            
            if strcmp(obj.materialLayer, 'SC')
                obj.delta = 0.2; %random guess for the gap
            else
                obj.delta = 0; %no gap if no superconductor at the start?
            end
            
            %fprintf('Lattice point created at (%d, %d) with type %s\n', obj.x, obj.y, obj.type);
        end
        function obj = classifyPoint(obj)
            % Classify the lattice point as corner, side or interior
            if (obj.x == 1 && obj.y == 1)
                obj.type = 'cornerUL';
                return
            elseif (obj.x == obj.system.Nx && obj.y == 1)
                obj.type = 'cornerUR';
                return
            elseif (obj.x == 1 && obj.y == obj.system.Ny)
                obj.type = 'cornerDL';
                return
            elseif (obj.x == obj.system.Nx && obj.y == obj.system.Ny)
                obj.type = 'cornerDR';
                return
            elseif obj.x == 1
                obj.type = 'sideL';
                return
            elseif obj.x == obj.system.Nx
                obj.type = 'sideR';
                return
            elseif obj.y == 1
                obj.type = 'sideU';
                return
            elseif obj.y == obj.system.Ny
                obj.type = 'sideD';
                return
            end

            obj.type = 'interior';
            return
        end

        function i = xy_to_i(obj,x, y)
            % Convert x, y coordinates to i index
            i = (y-1)*obj.system.Nx + x;
        end

        function [x, y] = i_to_xy(obj,i)
            % Convert i index to x, y coordinates
            x = ModNo0(i, obj.system.Nx);
            y = (i - x)/obj.system.Nx + 1;
        end

        
    end
end
