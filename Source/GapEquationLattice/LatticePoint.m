
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
        k
        F_x %[Fx+, Fx-]
        F_y %[Fy+,  Fy-]
        F_d 
        Delta_d %d-wave parameter = V/4 * F_d
    end
    properties (Constant)
        
    end
    
    methods
        % Constructor method to initialize coordinates
        function obj = LatticePoint(system, x, y)
            obj.system = system;
            if isa(system, 'SystemFourier')
                tilted = false; %this is not used in the fourier system
            else
                tilted = system.tilted;
            end
            if nargin == 3
                obj.x = x;
                obj.y = y;
                obj.i = system.xy_to_i(x, y);
         
            elseif nargin == 2
                obj.i = x; %the input is the index i
                [obj.x ,obj.y] = system.i_to_xy(obj.i);

            end

            obj.materialLayer = SystemBase.sampleTypeAt(obj.x, obj.y, tilted, numel(system.layer)/2);

            obj = obj.classifyPoint();
            %fprintf('created at %d with type %s\n', obj.i, obj.type);
            if strcmp(obj.materialLayer,'SC')
                rot = 0;
                obj.U = 2.0;
                if SystemBase.fixedBoundaryDeltaArg
                    if obj.x == 1 
                        obj.delta = system.fixedDelta(1);
                        rot = SystemBase.phi_1;
                    elseif obj.x == system.Nx
                        obj.delta = system.fixedDelta(2);
                        rot = SystemBase.phi_2;
                    else
                        obj.delta = abs(system.guessDelta)*exp(1i * obj.SamplePhaseAtGradient(obj.x, system));
                        rot = obj.SamplePhaseAtGradient(obj.x, system);
                    end
                    
                    %fprintf('created at %d with angle, %d', obj.x ,obj.SamplePhaseAtGradient(obj.x, system));
                elseif (SystemBase.fixedBoundaryDeltaNorm) && (obj.x == 1 || obj.x == system.Nx)
                    obj.delta = abs(system.guessDelta)*exp(1i * 0);
                else
                    obj.delta = system.guessDelta; %*exp( -((obj.x - system.Nx/2)^2 + (obj.y - system.Ny/2)^2) / 1000 );
                end
                obj.c_up_c_down = obj.delta / obj.U;
                obj.F_x = exp(-1i * rot) .* [1, 1] .* system.guessDelta; %according to mjøs p19
                obj.F_y = exp(-1i * rot) .* [-1, -1] .* system.guessDelta;
                obj.F_d = obj.F_x(1) + obj.F_x(2) - obj.F_y(1) - obj.F_y(2);
                obj.Delta_d = SystemFourier.V / 4 * obj.F_d;
            else
                obj.F_x = [0, 0]; %according to mjøs p19
                obj.F_y = [0, 0];
                obj.F_d = 0;
                obj.U = 0;    
                obj.delta = 0;       
                obj.c_up_c_down = 0; %for init it is not important what this is bc delta go inside ham and then write the c_up_c_down
            end

            obj.current = [0, 0];
            if isa(system, 'SystemFourier')
                num_cell = 2;
                
            elseif isa(system, 'System') || isa(system, 'System_DWave')
                num_cell = 4;
            else
                assert(false, 'System not recognized');
            end
            
            obj.neighbour = cell(num_cell, 1);   % cout counter clockwise : 1: +x 2: +y 3: -x 4: -y
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
            if isa(system, 'System') || isa(system, 'System_DWave')
                [my_cond, my_id] = CanFindNeigbour(obj.i, '-y', system);
                [py_cond, py_id] = CanFindNeigbour(obj.i, '+y', system);
                if mx_cond
                    obj.neighbour{3} = system.points{mx_id};
                    mx_id = system.points{mx_id}.i;
                end
                if px_cond
                    obj.neighbour{1} = system.points{px_id};
                    px_id = system.points{px_id}.i;
                end
                if my_cond
                    obj.neighbour{4} = system.points{my_id};
                    my_id = system.points{my_id}.i;
                end
                if py_cond
                    obj.neighbour{2} = system.points{py_id};
                    py_id = system.points{py_id}.i;
                end
            % fprintf('neighbours at %d: %d, %d, %d, %d\n', obj.i, px_id, py_id, mx_id, my_id);
            elseif isa(system, 'SystemFourier')
                if px_cond
                    obj.neighbour{1} = system.points{px_id};
                end
                if mx_cond
                    obj.neighbour{2} = system.points{mx_id};
                end
            end
            % if obj.i == 150
            %     fprintf('neighbours at %d: %d, %d, %d, %d\n', obj.i, mx_id, px_id, my_id, py_id);
            % end
        end

        function obj = updateDelta(obj, c_up_c_down, system)
            if (obj.x == 1 || obj.x == system.Nx)
                if SystemBase.fixedBoundaryDeltaNorm && SystemBase.fixedBoundaryDeltaArg

                    if obj.x == 1
                        rot = system.phi_1;
                    else
                        rot = system.phi_2;
                    end
                    if obj.U ~= 0
                        obj.delta = SystemBase.guessDelta * exp(1i*rot);
                        obj.c_up_c_down = obj.delta / obj.U; %we never intend to have two diffent object when fixing the phase
                    else
                        %obj.delta = 0; we leave it unchanged
                        obj.c_up_c_down = abs(c_up_c_down) * exp(1i*rot); %store this anyway, no guess to fix towards
                    end
                    return;
                    
                elseif SystemBase.fixedBoundaryDeltaNorm
                    if obj.U ~= 0
                        obj.delta = SystemBase.guessDelta * exp(1i* angle(c_up_c_down)) ;
                        obj.c_up_c_down = obj.delta / obj.U; %we never intend to have two diffent object when fixing the phase
                    else
                        obj.c_up_c_down = c_up_c_down; %no norm to fix towards
                    end
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

        function obj=updateF(obj, F_x, F_y)
            %fix the phase of values on the sides, only updates the abs of the values
            if SystemBase.fixedBoundaryDeltaArg
                if obj.x == 1
                    obj.F_x = exp(-1i * obj.system.phi_1) * [abs(F_x(1)), abs(F_x(2))];
                    obj.F_y = exp(-1i * obj.system.phi_1) * [abs(F_y(1)), abs(F_y(2))];
                    return;
                elseif obj.x == obj.system.Nx
                    obj.F_x = exp(-1i * obj.system.phi_2) * [abs(F_x(1)), abs(F_x(2))];
                    obj.F_y = exp(-1i * obj.system.phi_2) * [abs(F_y(1)), abs(F_y(2))];
                    return;
                end
            end
            obj.F_x = F_x;
            obj.F_y = F_y;
        end

        function obj = computeDWave(obj, system, neighbour_uv, energies)  
            Fermi = @(E) FermiDiarac(E, SystemBase.T);


            %neighbour_uv is (site, n, k, (u,v)) for fourier system
                %site =1:x-1 site =2:x site =3:x+1

            %neighbour_uv is (site, n, (u,v)) for dwave system
                %site =1:x site =2:x+1 site =3: y+1 site =4: x-1 site =5: y-1
            F_i_ip1 = 0.0;
            F_i_im1 = 0.0;
            F_i_ipN = 0.0;
            F_i_imN = 0.0;  

            %we already have the F_ij but need now F_ji
            F_ip1_i = 0.0;
            F_im1_i = 0.0;
            F_ipN_i = 0.0;
            F_imN_i = 0.0;
            if isa(system, 'SystemFourier')
                for n_id = 1 : size(neighbour_uv, 2)
               
                    for k_id = 1 : size(neighbour_uv, 3) %here we are going to reuse the u and v for different purposes

                        % F _{i-1 , i} along x
                        u_1 = neighbour_uv(1, n_id, k_id, 1); %1 means the site x-1
                        v_2 = neighbour_uv(2, n_id, k_id, 2); %2 means the site x, is used in each expressions
                        F_im1_i = F_im1_i + u_1 * conj(v_2) * (1 - Fermi(energies(n_id, k_id)));


                        % F _{i+1 , i} along x
                        u_1 = neighbour_uv(3, n_id, k_id, 1); %here we reuse u1 for the site x+1 : 3
                        F_ip1_i = F_ip1_i + u_1 * conj(v_2) * (1 - Fermi(energies(n_id, k_id)));


                        % F _{i-1 , i} along y
                        u_2 = neighbour_uv(2, n_id, k_id, 1); %in this y hopping, we look at the uv on the same site but different k in exp
                        F_imN_i = F_imN_i + u_2 * conj(v_2) * (1 - Fermi(energies(n_id, k_id))) * exp(1i*system.k(k_id));


                        % F _{i+1 , i} along y, same statement for the u and v
                        F_ipN_i = F_ipN_i + u_2 * conj(v_2) * (1 - Fermi(energies(n_id, k_id)))* exp(-1i*system.k(k_id));


                    end
                    F_xplus_S = (F_i_ip1 + F_ip1_i)/2; %both summand differ in the u, v
                    F_xminus_S = (F_i_im1 + F_im1_i)/2;
        
                    F_yplus_S = (F_i_ipN + F_ipN_i)/2; %both summand differ in the exopnential part
                    F_yminus_S = (F_i_imN + F_imN_i)/2;
                end

            elseif isa(system, 'System_DWave')
                factor = 1.0;
                for n_id = 1 : size(neighbour_uv, 2)

                    %on site members
                    u_i_up   = neighbour_uv(1, n_id, 1);
                    u_i_down = neighbour_uv(1, n_id, 2);
                    v_i_up   = neighbour_uv(1, n_id, 3); 
                    v_i_down = neighbour_uv(1, n_id, 4);

                    % F along x +
                    %* OK
                    u_i_p1_up   = neighbour_uv(2, n_id, 1); 
                    u_i_p1_down = neighbour_uv(2, n_id, 2); 
                    v_i_p1_up   = neighbour_uv(2, n_id, 3);
                    v_i_p1_down = neighbour_uv(2, n_id, 4); 

                    F_ip1_i = F_ip1_i + u_i_p1_up * conj(v_i_down)    * (1 - Fermi(factor*energies(n_id))) + conj(v_i_p1_up) * u_i_down    * Fermi(factor*energies(n_id));
                    F_i_ip1 = F_i_ip1 + u_i_up    * conj(v_i_p1_down) * (1 - Fermi(factor*energies(n_id))) + conj(v_i_up)    * u_i_p1_down * Fermi(factor*energies(n_id));
                    
                    % F along y +
                    %* OK
                    u_i_pN_up   = neighbour_uv(3, n_id, 1); 
                    u_i_pN_down = neighbour_uv(3, n_id, 2); 
                    v_i_pN_up   = neighbour_uv(3, n_id, 3); 
                    v_i_pN_down = neighbour_uv(3, n_id, 4); 

                    F_ipN_i = F_ipN_i + u_i_pN_up * conj(v_i_down) * (1 - Fermi(factor*energies(n_id))) + conj(v_i_pN_up) * u_i_down * Fermi(factor*energies(n_id));
                    F_i_ipN = F_i_ipN + u_i_up * conj(v_i_pN_down) * (1 - Fermi(factor*energies(n_id))) + conj(v_i_up) * u_i_pN_down * Fermi(factor*energies(n_id));
                    
                    % F along x-
                    %* OK
                    u_i_m1_up   = neighbour_uv(4, n_id, 1); 
                    u_i_m1_down = neighbour_uv(4, n_id, 1); 
                    v_i_m1_up   = neighbour_uv(4, n_id, 3); 
                    v_i_m1_down = neighbour_uv(4, n_id, 4);
                    
                    F_im1_i = F_im1_i + u_i_m1_up * conj(v_i_down) * (1 - Fermi(factor*energies(n_id))) + conj(v_i_m1_up) * u_i_down * Fermi(factor*energies(n_id));
                    F_i_im1 = F_i_im1 + u_i_up * conj(v_i_m1_down) * (1 - Fermi(factor*energies(n_id))) + conj(v_i_up) * u_i_m1_down * Fermi(factor*energies(n_id));

                    % F along y-
                    %* OK
                    u_i_mN_up   = neighbour_uv(5, n_id, 1); 
                    u_i_mN_down = neighbour_uv(5, n_id, 2);
                    v_i_mN_up   = neighbour_uv(5, n_id, 3); 
                    v_i_mN_down = neighbour_uv(5, n_id, 4);

                    F_imN_i = F_imN_i + u_i_mN_up * conj(v_i_down) * (1 - Fermi(factor*energies(n_id))) + conj(v_i_mN_up) * u_i_down * Fermi(factor*energies(n_id));
                    F_i_imN = F_i_imN + u_i_up * conj(v_i_mN_down) * (1 - Fermi(factor*energies(n_id))) + conj(v_i_up) * u_i_mN_down * Fermi(factor*energies(n_id));


                end
                obj.F_x = [F_i_ip1, F_i_im1];
                obj.F_y = [F_i_ipN, F_i_imN];

                F_xplus_S = (obj.F_x(1) + F_ip1_i)/2; 
                F_xminus_S = (obj.F_x(2) + F_im1_i)/2;
    
                F_yplus_S = (obj.F_y(1) + F_ipN_i)/2; 
                F_yminus_S = (obj.F_y(1) + F_imN_i)/2;
            end
            obj.F_d = (F_xplus_S + F_xminus_S - F_yplus_S - F_yminus_S);

            if isa(system, 'SystemFourier')
                obj.Delta_d = (SystemFourier.V / 4) * obj.F_d;
            else
                obj.Delta_d = (System_DWave.V / 4) * obj.F_d;
            end
        end

        % function bool = foundAllNeighbours(obj)
        %     for j = 1:4
        %         if isempty(obj.neighbour{j})
        %             bool = false;
        %             return;
        %         end
        %     end
        %     bool = true;
        % end
    end
    methods (Static)
        function angle = SamplePhaseAtGradient(x,system)
            angle = x/system.Nx * (SystemBase.phi_2 - SystemBase.phi_1) + SystemBase.phi_1;
        end
    end
end
