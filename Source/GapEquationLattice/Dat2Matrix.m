% used for a general mean line purpose
function  matrix = Dat2Matrix(data) %matrix hqving one entry per lattice point coordianteand mutliple slices for different datas
    


    % Extract X, Y, and values
    X = data(:, 1); % First column is X
    Y = data(:, 2); % Second column is Y
    number_of_datas =  size(data, 2) - 2;
    % Determine the matrix dimensions based on max X and Y values
    maxX = max(X);
    maxY = max(Y);

    % Initialize an empty matrix with NaNs (or zeros if preferred)
    matrix = NaN(maxY, maxX, number_of_datas);

    % Populate the matrix using X, Y as indices anf filling the slices with the data
    for slice = 1 : number_of_datas
        for i = 1 : size(data, 1) %number of rows
            matrix(Y(i), X(i), slice) = data(i, 2 + slice);
        end
    end

end