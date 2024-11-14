
path = ".\Results\SC30diffMU\";
model = "\LinearPhaseGradient\";
pot = ["-3.75", "2.75", "0.75"];
file_to_check = ["1.0472"];
for p = 1:numel(pot)
    for i = 1:numel(file_to_check)
        file = strcat(path, pot(p),model, file_to_check(i), "\continuity_30x15NoBC.dat");
        if isfile(file)
            T = readmatrix(file);
            matrix = Dat2Matrix(T);

            out = MeanLineMatrix(matrix,'');
            dest = strcat(path,pot(p), model, file_to_check(i), "\meanline_Continuity_30x15NoBC_30x15NoBC.dat");
            writematrix(out, dest,'Delimiter',' ');
            fprintf("File %s created\n", dest);
        else
            fprintf("File not found, %s\n", file);
        end
    end
end