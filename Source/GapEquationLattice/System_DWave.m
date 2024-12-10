classdef System_DWave < System
    %This a simple child that activates the d wave switch in the parent
    methods
        function obj = System_DWave()
            %% object intialization
            obj = obj@System(true);
            obj.DWavePurpose = true;
            obj.convergence_model = "abs_angle";
        end

    end
end