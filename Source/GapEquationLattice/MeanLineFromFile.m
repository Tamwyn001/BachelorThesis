function MeanLineFromFile(quantity)
    path = ".\Results\SC12AM6SC12_m0.5\NotFourier\FixedLinearPhaseGradient\Phase117deg\diffMU\";
    pot = ["-3.75", "-2.75", "-1.75", "-0.75", "0.75", "1.75", "2.75", "3.75"];
    starting_at = "\Starting_at\1.0472";
    if nargin == 0
        quantity = "Continuity";
    end
    for p = 1:numel(pot)
        file = strcat(path, pot(p), starting_at,"\" ,lower(quantity),"_30x20NoBC.dat");
        if isfile(file)
            T = readmatrix(file);
            matrix = Dat2Matrix(T);
            out = MeanLineMatrix(matrix,'');
            dest = strcat(path,pot(p), starting_at, "\meanline_", quantity,"_30x20NoBC.dat");
            writematrix(out, dest,'Delimiter',' ');
            fprintf("File %s created\n", dest);
        else
            fprintf("File not found, %s\n", file);
        end
        
    end
end
