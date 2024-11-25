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
                if num == 1
                    total = size(dist,1);
                else
                    total = size(dist,1,1);
                end
                for i = 1 : total
                    if abs(dist(i,1,v)) > treshold
                        %fprintf('RE not reached at %d with %d\n', i,dist(i,1));
                        result = false;
                        break;
                    end
                    if abs(dist(i,2,v)) > treshold
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
                result = zeros(system.Nx*system.Ny, 1);
                for j = 1: system.Nx * system.Ny
                    result(j) = system.points{j}.delta;
                end
            end
        end
        
        function result = computeDistance(delta_old, delta_new, num)  
            length = size(delta_old, 1);
            result = zeros(length, 2, num);
            %the data is SiteX (imag) x Direction F
            %we generate SiteX (imag) x 2 (real , imag) x Direction F
            for dir = 1 : num
                for i = 1 : length
                    result(i, 1, dir) = (real(delta_new(i,dir)) - real(delta_old(i,dir))) / real(delta_old(i, dir)) * 100.0; %relative error from the old to new step
                    if ~isnan(imag(delta_old(i)))
                        result(i, 2, dir) = (imag(delta_new(i, dir)) - imag(delta_old(i, dir))) / imag(delta_old(i, dir)) * 100.0;
                    else
                        result(i, 2, dir) = 0.0;
                    end
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
            disp(path_CORREL_C);
            writematrix(WriteHeatmap(system, 'correl_c_c'), path_CORREL_C,'Delimiter',' ')

            path_PHASE = strcat(path, "phase_",sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'phase'), path_PHASE,'Delimiter',' ')

            path_CONTINUITY = strcat(path, "continuityV2_",sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'continuity'), path_CONTINUITY,'Delimiter',' ')

            path_MEAN_CORREL_C = strcat(path, "meanline_",sim_deltails, ".dat");
            writematrix(MeanLineMatrix(CORREL_C, 'abs'), path_MEAN_CORREL_C,'Delimiter',' ');

            pathMEAN_RE = strcat(path,"meanline_RE_",sim_deltails, ".dat");
            writematrix(MeanLineMatrix(CORREL_C, 'real'), pathMEAN_RE,'Delimiter',' ');

            pathMEAN_IM = strcat(path, "meanline_IM_",sim_deltails, ".dat");
            writematrix(MeanLineMatrix(CORREL_C,'imag'), pathMEAN_IM,'Delimiter',' ');

            pathCURRENT = strcat(path, "currentV2_",sim_deltails, ".dat");
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
    end
end