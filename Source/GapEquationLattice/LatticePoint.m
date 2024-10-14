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
        current %current of the site
        neighbour % cout counter clockwise : 1: +x 2: +y 3: -x 4: -y
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
            obj.current = [0, 0];
            %fprintf('Lattice point created at (%d, %d) with type %s\n', obj.x, obj.y, obj.type);
            obj.neighbour = cell(4,1);  
        end
        function obj = classifyPoint(obj)
            % Classify the lattice point as corner, side or interior
            if (obj.x == 1 && obj.y == 1)
                obj.type = 'cornerDL';
                return
            elseif (obj.x == obj.system.Nx && obj.y == 1)
                obj.type = 'cornerDR';
                return
            elseif (obj.x == 1 && obj.y == obj.system.Ny)
                obj.type = 'cornerUL';
                return
            elseif (obj.x == obj.system.Nx && obj.y == obj.system.Ny)
                obj.type = 'cornerUR';
                return
            elseif obj.x == 1
                obj.type = 'sideL';
                return
            elseif obj.x == obj.system.Nx
                obj.type = 'sideR';
                return
            elseif obj.y == 1
                obj.type = 'sideD';
                return
            elseif obj.y == obj.system.Ny
                obj.type = 'sideU';
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

        function obj = findNeighbours(obj, system)
            [mx_cond, mx_id] = CanFindNeigbour(obj.i, '-x', system);
            [px_cond, px_id] = CanFindNeigbour(obj.i, '+x', system);
            [my_cond, my_id] = CanFindNeigbour(obj.i, '-y', system);
            [py_cond, py_id] = CanFindNeigbour(obj.i, '+y', system);
            if mx_cond
                obj.neighbour{3} = system.points{mx_id};
            end
            if px_cond
                obj.neighbour{1} = system.points{px_id};
            end
            if my_cond
                obj.neighbour{4} = system.points{my_id};
            end
            if py_cond
                obj.neighbour{2} = system.points{py_id};
            end

        end

        
    end
end
