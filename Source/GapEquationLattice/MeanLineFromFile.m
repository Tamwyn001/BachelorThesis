function MeanLineFromFile(quantity)
    path = ".\Results\SC30\NotFourier\TiltedInterface\FixedLinearPhaseGradient\Phase117deg\diffMU\";
    pot = ["-2.5", "-1.5", "-0.5"];
    starting_at = "\Starting_at\1.0472";
    if nargin == 0
        quantity = "Continuity";
    end
    for p = 1:numel(pot)
        file = strcat(path, pot(p), starting_at,"\" ,lower(quantity),"_30x15NoBC.dat");
        if isfile(file)
            T = readmatrix(file);
            matrix = Dat2Matrix(T);
            out = MeanLineMatrix(matrix,'');
            dest = strcat(path,pot(p), starting_at, "\meanline_", quantity,"_30x15NoBC.dat");
            writematrix(out, dest,'Delimiter',' ');
            fprintf("File %s created\n", dest);
        else
            fprintf("File not found, %s\n", file);
        end
        
    end
end
