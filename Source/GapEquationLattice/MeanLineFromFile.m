
path = ".\Results\SC30diffMU\";
model = "\FixedFlatPhase\";
pot = ["0.75", "2.75"];
file_to_check = ["0.5236", "1.0472", "-1.0472"];
for p = 1:numel(pot)
    for i = 1:numel(file_to_check)
        file = strcat(path, pot(p),model, file_to_check(i), "\phase_30x15NoBC.dat");
        if isfile(file)
            T = readmatrix(file);
            matrix = Dat2Matrix(T);

            out = MeanLineMatrix(matrix,'');
            writematrix(out, strcat(path,pot(p), model, file_to_check(i), "\meanline_Phase_30x15NoBC.dat"),'Delimiter',' ');
            fprintf("File %s created\n", file);
        else
            fprintf("File not found, %s\n", file);
        end
    end
end