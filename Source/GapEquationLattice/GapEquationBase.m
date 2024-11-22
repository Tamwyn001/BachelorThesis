classdef GapEquationBase
    %a few function we may use in different versions of the gap equation
    properties
    end

    methods

    end
    
    methods(Static)
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

        function result = thresholdReached(dist, treshold)
            result = true;
            for i = 1: size(dist,1)
                if abs(dist(i,1)) > treshold
                    %fprintf('RE not reached at %d with %d\n', i,dist(i,1));
                    result = false;
                    break;
                end
                if abs(dist(i,2)) > treshold
                    %fprintf('IM not reached at %d with %d\n', i,dist(i,2));
                    result = false;
                    break;
                end
            end
            return;
        end
        
        function result = generateNewCollumnDelta(system)
            index_shift = 0;
            result = zeros(system.Nx*system.Ny, 1);
            for j = 1: system.Nx * system.Ny
                result(j - index_shift) = system.points{j}.delta;
            end
        end
        
        function result = computeDistance(delta_old, delta_new)  
            length = size(delta_old, 1);
            result = zeros(length, 2);
            for i = 1: length
                result(i,1) = (real(delta_new(i)) - real(delta_old(i))) / real(delta_old(i)) * 100.0; %relative error from the old to new step
                if ~isnan(imag(delta_old(i)))
                    result(i,2) = (imag(delta_new(i)) - imag(delta_old(i))) / imag(delta_old(i)) * 100.0;
                else
                    result(i,2) = 0.0;
                end
            end
        end
        
        function loop_on = canLoop(terminated, dist, treshold)
            loop_on = true;
            if GapEquationBase.thresholdReached(dist, treshold) 
                loop_on = false;
                return;
            elseif terminated
                loop_on = false;
                return;
            end
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