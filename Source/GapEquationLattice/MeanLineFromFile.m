
path = ".\Results\SC12AM6SC12\NotFourier\FixedLinearPhaseGradient\Phase117deg\diffMU\";
pot = ["-3.75", "-2.75", "-1.75", "3.75", "2.75", "1.75"];
for p = 1:numel(pot)
    file = strcat(path, pot(p),  "\Starting_at\1.0472\continuity_30x15VertBC.dat");
    if isfile(file)
        T = readmatrix(file);
        matrix = Dat2Matrix(T);

        out = MeanLineMatrix(matrix,'');
        dest = strcat(path,pot(p),  "\Starting_at\1.0472\meanline_Continuity_30x15VertBC.dat");
        writematrix(out, dest,'Delimiter',' ');
        fprintf("File %s created\n", dest);
    else
        fprintf("File not found, %s\n", file);
    end
    
end