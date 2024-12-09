classdef GapEquationBase
    %a few function we may use in different versions of the gap equation
    properties
    end

    methods

    end

    methods(Static)
        function result = thresholdReached(dist, treshold, num)
            result = true;
            for v = 1 : num
                if ~result % one break causes everything to stop
                    break;
                end
                total = size(dist,1); %this works for both cases

                for i = 1 : total
                    if abs(dist(i,1,v)) > treshold
                        %fprintf('RE not reached at %d with %d\n', i,dist(i,1));
                        result = false;
                        break;
                    end
                    if (abs(dist(i,2,v)) > treshold)
                        %fprintf('IM not reached at %d with %d\n', i,dist(i,2));
                        result = false;
                        break;
                    end
                end
            end
            return;
        end

        function result = generateNewCollumnDeltaOrF(system)

            if isa(system, 'SystemFourier')
                result = zeros(system.Nx, 4); % +x, -x, +y, -y
                for j = 1: system.Nx
                    result(j,1) = system.points{j}.F_x(1);
                    result(j,2) = system.points{j}.F_x(2);
                    result(j,3) = system.points{j}.F_y(1);
                    result(j,4) = system.points{j}.F_y(2);
                end

            elseif isa(system, 'System')
                result = zeros(system.Nx*system.Ny, 2); %stores angle and |delta|
                % debug_check_at = 408;
                for j = 1: system.Nx * system.Ny
                    result(j,1) = abs(system.points{j}.delta);

                    result(j,2) = 0.0;
                    coord_check = zeros(4,1);
                    for nei_id = 1 : 4
                        nei = system.points{j}.neighbour{nei_id};
                        if ~isempty(nei)
                            coord_check(nei_id) = system.xy_to_i(nei.x, nei.y); %we store a zero id nei not valid
                        end
                    end
                    % if j == debug_check_at
                    %     fprintf('Checking on site %d having angle %.5f\n', debug_check_at,angle(system.points{debug_check_at}.delta));
                    % end
                    for i = 1: numel(coord_check)
                        if coord_check(i) ~= 0 % i represent the direction of the neighbour clockwise starting from the right

                            if coord_check(i) < j %sign is for (f+x) - f (-x)
                                sign = -1;
                            else
                                sign = 1;
                            end
                            result(j,2) = result(j,2) + sign * angle(system.points{coord_check(i)}.delta);
                        end
                        % if j == debug_check_at
                        % fprintf(' -Checking on site nei ID %d having angle %.5f \n',i, angle(system.points{debug_check_at}.delta));
                        % end
                    end
                    % if j == debug_check_at
                    %     fprintf('>Checking on site %d having continuity %.5f\n\n', debug_check_at,result(245,2));
                    % end
                end
            end
        end

        function result = computeDistance(delta_old, delta_new, num)
            length = size(delta_old, 1);
            result = zeros(length, 2, num); %site x real/imag x number of vars to check
            %the data is SiteX (imag) x Direction F
            %we generate SiteX (imag) x 2 (real , imag) x Direction F
            for dir = 1 : num
                for i = 1 : length
                    % if i == 245
                    %     fprintf('Checking on site 245 having angle old: %.5f, new %.5f, diff %5f\n', delta_old(245,2), delta_new(245,2), (real(delta_new(i,2)) - real(delta_old(i,2))) / real(delta_old(i, 2)) * 100.0);
                    % end

                    %avoid a 0 division for the continuity for ex.
                    if strcmp(SystemBase.convergence_model,"re_im")
                        if real(delta_old(i, dir)) == 0.0
                            safe_real = 0.01; 
                            %fprintf('Warning: real delta is 0 at site %d\n', i);
                        else
                            safe_real = real(delta_old(i, dir));
                        end
                        if imag(delta_old(i, dir)) == 0.0
                            safe_imag = 0.01;
                        else
                            safe_imag = imag(delta_old(i, dir));
                        end
                    elseif strcmp(SystemBase.convergence_model,"abs_angle")
                        if abs(delta_old(i, dir)) == 0.0
                            safe_abs = 0.01; 
                            %fprintf('Warning: real delta is 0 at site %d\n', i);
                        else
                            safe_abs = abs(delta_old(i, dir));
                        end
                        if angle(delta_old(i, dir)) == 0.0
                            safe_angle = 0.01;
                        else
                            safe_angle = angle(delta_old(i, dir));
                        end
                    end
                    %there is some high fluctuations in the almost nummericaly zero case, so we cut of if too small 
                    % otherwise we get a get jumps from -16 to -13 for example which is a 1000% jump
                    if (abs(delta_new(i,dir))<1e-10 && abs(delta_old(i,dir))<1e-10) %|| (mod(i-1,30) +1 > 15)
                        result(i, 1, dir) = 0.0;
                        result(i, 2, dir) = 0.0;
                    else
                        if strcmp(SystemBase.convergence_model, 're_im')
                            result(i, 1, dir) = (real(delta_new(i,dir)) - real(delta_old(i,dir))) / safe_real * 100.0; %relative error from the old to new step
                            if ~isnan(imag(delta_old(i,dir)))
                                result(i, 2, dir) = (imag(delta_new(i, dir)) - imag(delta_old(i, dir))) / safe_imag * 100.0;
                            else
                                result(i, 2, dir) = 0.0;
                            end
                        elseif strcmp(SystemBase.convergence_model, 'abs_angle')
                            result(i, 1, dir) = (abs(delta_new(i,dir)) - abs(delta_old(i,dir))) / safe_abs * 100.0; %relative error from the old to new step
                            result(i, 2, dir) = (angle(delta_new(i,dir)) - angle(delta_old(i,dir))) / safe_angle * 100.0;
                        end
                    end
                    % if i == 20 && dir ==1
                    %     fprintf('Dist at 20 re F+x: %.5f, new %.5f, old %.5f\n', result(i, 1, dir), real(delta_new(i,dir)), real(delta_old(i,dir)));
                    % end
                end
            end
        end

        function loop_on = canLoop(terminated, dist, treshold, num)
            loop_on = true;
            if GapEquationBase.thresholdReached(dist, treshold, num)
                loop_on = false;
                return;
            elseif terminated
                loop_on = false;
                return;
            end
        end



        function saveResults(path, sim_deltails, system, CORREL_C)

            path_CORREL_C = strcat(path, sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'correl_c_c'), path_CORREL_C,'Delimiter',' ')

            path_PHASE = strcat(path, "phase_",sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'phase'), path_PHASE,'Delimiter',' ')

            path_CONTINUITY = strcat(path, "continuity_",sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'continuity'), path_CONTINUITY,'Delimiter',' ')

            path_MEAN_CORREL_C = strcat(path, "meanline_",sim_deltails, ".dat");
            writematrix(MeanLineMatrix(CORREL_C, 'abs'), path_MEAN_CORREL_C,'Delimiter',' ');

            % pathMEAN_RE = strcat(path,"meanline_RE_",sim_deltails, ".dat");
            % writematrix(MeanLineMatrix(CORREL_C, 'real'), pathMEAN_RE,'Delimiter',' ');

            % pathMEAN_IM = strcat(path, "meanline_IM_",sim_deltails, ".dat");
            % writematrix(MeanLineMatrix(CORREL_C,'imag'), pathMEAN_IM,'Delimiter',' ');

            pathCURRENT = strcat(path, "current_",sim_deltails, ".dat");
            writematrix(WriteVectorField(system), pathCURRENT,'Delimiter',' ');

            disp(sprintf('Saved at: %s', path));

        end

        function sim_deltails = getSimulationDetails(system)
            sim_deltails = strcat(int2str(system.Nx),'x', int2str(system.Ny));
            if SystemBase.verticalPeriodicBoundary && SystemBase.horizontalPeriodicBoundary
                sim_deltails = strcat(sim_deltails, "VertHorizBC");
            elseif SystemBase.verticalPeriodicBoundary
                sim_deltails = strcat(sim_deltails, "VertBC");
            elseif SystemBase.horizontalPeriodicBoundary
                sim_deltails = strcat(sim_deltails, "HorizBC");
            else
                sim_deltails = strcat(sim_deltails, "NoBC");
            end
        end

        function phase_shift_folder = getPhaseShiftFolder(system)
            if SystemBase.fixedBoundaryDeltaArg
                phase_shift_folder = "\Fixed";
                if SystemBase.fixedBoundaryDeltaNorm
                    phase_shift_folder = strcat(phase_shift_folder, "Norm");
                end
                phase_shift = round((system.phi_2 - system.phi_1) * (180/pi));
                if phase_shift == 0
                    phase_shift_folder = strcat(phase_shift_folder, "PhaseDelta\PhaseSide", num2str(SystemBase.phi_1), ...
                        "\diffMU\", num2str(SystemBase.mu),"\");
                else
                    phase_shift_folder = strcat(phase_shift_folder, "LinearPhaseGradient\Phase", num2str(phase_shift), "deg\",...
                        "diffMU\", num2str(SystemBase.mu),"\", "Starting_at\", num2str(SystemBase.phi_1),"\");
                end

            elseif SystemBase.fixedBoundaryDeltaNorm
                phase_shift_folder = strcat("\FixedDeltaNorm\diffMU\mu_delta_", num2str(SystemBase.mu),"_",num2str(SystemBase.guessDelta),"\");
            else
                phase_shift_folder = strcat("\FreeDelta\diffMU\", num2str(SystemBase.mu),"\");
            end
        end
        function mat = getSimMaterial()
            mat = "";
            for i = 1 : numel(SystemBase.layer)
                mat = strcat(mat, SystemBase.layer(i));
            end
        end
    end

end