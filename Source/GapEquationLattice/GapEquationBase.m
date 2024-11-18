classdef GapEquationBase
    %a few function we may use in different versions of the gap equation
    properties
    end

    methods

    end
    
    methods(Static)
        function saveResults(path, sim_deltails, system, CORREL_C)         
            path_CORREL_C = strcat(path, sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'correl_c_c'), path_CORREL_C,'Delimiter',' ')

            path_PHASE = strcat(path, "phase_",sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'phase'), path_PHASE,'Delimiter',' ')

            path_CONTINUITY = strcat(path, "continuity_",sim_deltails, ".dat");
            writematrix(WriteHeatmap(system, 'continuity'), path_CONTINUITY,'Delimiter',' ')

            path_MEAN_CORREL_C = strcat(path, "meanline_",sim_deltails, ".dat");
            writematrix(MeanLineMatrix(CORREL_C, ''), path_MEAN_CORREL_C,'Delimiter',' ');

            pathMEAN_RE = strcat(path,"meanline_RE_",sim_deltails, ".dat");
            writematrix(MeanLineMatrix(CORREL_C, 'real'), pathMEAN_RE,'Delimiter',' ');

            pathMEAN_IM = strcat(path, "meanline_IM_",sim_deltails, ".dat");
            writematrix(MeanLineMatrix(CORREL_C,'imag'), pathMEAN_IM,'Delimiter',' ');

            pathCURRENT = strcat(path, "current_",sim_deltails, ".dat");
            writematrix(WriteVectorField(system), pathCURRENT,'Delimiter',' ');
            
            disp(sprintf('Saved at: %s', strcat(path, phase_shift_folder)));

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
            if system.fixedBoundaryDelta
                result = zeros(system.Nx*(system.Ny-2), 1); %subtract the sides 2 Nx elements
            else
                result = zeros(system.Nx*system.Ny, 1);
            end
            for j = 1: system.Nx * system.Ny
                if ~system.points{j}.isSubjectToFixedDelta(system)
                    result(j - index_shift) = system.points{j}.delta;
                else
                    index_shift = index_shift + 1; %we need to come back t0 the right index
                end
            end
        end
        
        function result = computeDistance(delta_old, delta_new)  
            length = size(delta_old, 1);
            result = zeros(length, 2);
            for i = 1: length
                result(i,1) = (real(delta_new(i)) - real(delta_old(i))) / real(delta_old(i)) * 100.0; %relative error from the old to new step
                result(i,2) = (imag(delta_new(i)) - imag(delta_old(i))) / imag(delta_old(i)) * 100.0;
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

        function sim_deltails = getSimulationDetails()
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

            systemMaterial = "";
            for i = 1 : numel(SystemBase.layer)
                systemMaterial = strcat(systemMaterial, SystemBase.layer(i));
            end
        end
  
        function phase_shift_folder = getPhaseShiftFolder()
            phase_shift_folder = "";
            if SystemBase.fixedBoundaryDelta || SystemBase.fixedBoundaryDeltaArg
                phase_shift = round((system.phi_2 - system.phi_1) * (180/pi));
                phase_shift_folder = strcat("\Phase", num2str(phase_shift), "deg\");
            end
        end
    end
end