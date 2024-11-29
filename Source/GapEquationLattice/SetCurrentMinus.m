
path = ".\Results\SC30\NotFourier\FixedLinearPhaseGradient\Phase117deg\diffMU\";
pot = ["-3.75", "-2.75", "-1.75", "3.75", "2.75", "1.75"];
phase_start = ["1.0472", "-1.0472"] ;
for p = 1:numel(pot)
    for phase_id = 1:2
        file = strcat(path, pot(p),  "\Starting_at\", phase_start(phase_id), "\current_30x15NoBC.dat");
        if isfile(file)
            T = readmatrix(file);
            matrix_write = zeros(size(T));

                disp(T);
            for i = 1:size(T,1)
                for j = 1:size(T,2) 
                    fprintf('Before %f %f %f %f\n', T(i,1), T(i,2), T(i,3), T(i,4));
                    if j >= 3
                        matrix_write(i,j) = -1.0*T(i,j);
                       
                    else
                        matrix_write(i,j) = T(i,j);
                    end
                    fprintf('After %f %f %f %f\n\n', T(i,1), T(i,2), T(i,3), T(i,4));
                end
            end

            writematrix(matrix_write, file,'Delimiter',' ');
            fprintf("File %s created\n", file);
        else
            fprintf("File not found, %s\n", file);
        end
    end
end