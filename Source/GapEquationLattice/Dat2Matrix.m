% used for a general mean line purpose
function  matrix = Dat2Matrix(data) %Nx3 matrix
    


    % Extract X, Y, and values
    X = data(:, 1); % First column is X
    Y = data(:, 2); % Second column is Y
    values = data(:, 3); % Third column is the value

    % Determine the matrix dimensions based on max X and Y values
    maxX = max(X);
    maxY = max(Y);

    % Initialize an empty matrix with NaNs (or zeros if preferred)
    matrix = NaN(maxY, maxX);

    % Populate the matrix using X, Y as indices
    for i = 1:length(values)
        matrix(Y(i), X(i)) = values(i);
    end

end