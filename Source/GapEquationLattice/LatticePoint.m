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
        c_up_c_down
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
                obj.materialLayer = SystemBase.sampleTypeAt(obj.x);
         
            elseif nargin == 2
                obj.i = x; %the input is the index i
                [obj.x ,obj.y] = obj.i_to_xy(obj.i);
                %fprintf('x: %d, y: %d\n', obj.x, obj.y);
                obj.materialLayer = SystemBase.sampleTypeAt(obj.x);
            end

            obj = obj.classifyPoint();

            if strcmp(obj.materialLayer,'SC')
                obj.U = 2;
            else
                obj.U = 0;           
            end

            if SystemBase.fixedBoundaryDeltaArg
                if obj.x == 1 
                    obj.delta = system.fixedDelta(1);
                elseif obj.x == system.Nx
                    obj.delta = system.fixedDelta(2);
                else
                    obj.delta = abs(system.guessDelta)*exp(1i * obj.SamplePhaseAtGradient(obj.x, system));
                end
            elseif (SystemBase.fixedBoundaryDeltaNorm) && (obj.x == 1 || obj.x == system.Nx)
                obj.delta = abs(system.guessDelta)*exp(1i * 0);
            else
                obj.delta = system.guessDelta;
            end

            obj.c_up_c_down = obj.delta / obj.U;

            obj.current = [0, 0];
            obj.neighbour = cell(4,1);   % cout counter clockwise : 1: +x 2: +y 3: -x 4: -y
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

        function i = xy_to_i(obj, x, y)
            % Convert x, y coordinates to i index
            i = (y-1)*obj.system.Nx + x;
        end

        function [x, y] = i_to_xy(obj,i)
            % Convert i index to x, y coordinates
            x = mod(i-1, obj.system.Nx) + 1;
            y = floor((i-1)/obj.system.Nx) + 1;
        end


        % function id = findInNeighbours(obj, point)
        %     id = -1;
        %     for j = 1:4
        %         if obj.neighbour{j} == point
        %             id = j;
        %             return;
        %         end
        %     end
        % end

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

        function obj = updateDelta(obj, c_up_c_down, system)
            if (obj.x == 1 || obj.x == system.Nx)
                if SystemBase.fixedBoundaryDeltaNorm && SystemBase.fixedBoundaryDeltaArg

                    if obj.x == 1
                        rot = system.phi_1;
                    else
                        rot = system.phi_2;
                    end
                    obj.delta = SystemBase.guessDelta * exp(1i*rot);
                    obj.c_up_c_down = obj.delta / obj.U; %we never intend to have two diffent object when fixing the phase
                    %disp(obj.delta);
                    return;
                    
                elseif SystemBase.fixedBoundaryDeltaNorm

                    obj.delta = SystemBase.guessDelta * exp(1i* angle(c_up_c_down)) ;
                    obj.c_up_c_down = obj.delta / obj.U; %we never intend to have two diffent object when fixing the phase
                    %disp(obj.delta);
                    return;
                    
                elseif SystemBase.fixedBoundaryDeltaArg
                    % rot = system.phi_1;
                    if obj.x == 1
                        rot = system.phi_1;
                    else
                        rot = system.phi_2;
                    end
                    obj.c_up_c_down =  abs(c_up_c_down) *exp(1i*rot);
                    obj.delta = obj.U * obj.c_up_c_down;
                    return;
                end
            end
            obj.c_up_c_down = c_up_c_down;
            obj.delta = c_up_c_down * obj.U;
        end

    end
    methods (Static)
        function angle = SamplePhaseAtGradient(x,system)
            angle = x/system.Nx * (SystemBase.phi_2 - SystemBase.phi_1) + SystemBase.phi_1;
        end
    end
end
