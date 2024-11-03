
path = ".\Results\";
model = "SC30\Phase117deg\diffMU\ZeroPhase\";
file_to_check = ["-4.75" , "-3.75" , "-2.75" , "-1.75" , "-0.75" , "0" , "0.75", "1.75", "2.75", "3.75", "4.75"];
for i = 1:numel(file_to_check)
    file = strcat(path, model, file_to_check(i), "\phase_30x15NoBC.dat");
    if isfile(file)
        T = readmatrix(file);
        matrix = Dat2Matrix(T);

        out = MeanLineMatrix(matrix);
        writematrix(out, strcat(path, model, file_to_check(i), "\meanline_Phase_30x15NoBC.dat"),'Delimiter',' ');
        fprintf("File %s created\n", file);
    else
        fprintf("File not found, %s\n", file);
    end
end
