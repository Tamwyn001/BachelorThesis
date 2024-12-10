function  meanLine = MeanLineMatrix(matrix, part)

    sizeMM = size(matrix);
    sizesizeMM = size(sizeMM);
    if sizesizeMM(2) == 2
        num_param = 1;
    else
        num_param = sizeMM(3);
    end
    meanLine = zeros(sizeMM(2), num_param); %x and variables

    for j = 1 : sizeMM(2) % for each vertical lines
        meanLine(j,1) = j; %store x id
        total = zeros(num_param,1); % a vector having the sum of each variable in this vertical line
        for i = 1 : sizeMM(1) % loop over the elems of the vertical line
            for slice = 1 : num_param 
                if strcmp(part, 'real')
                    total(slice) = total(slice) + real(matrix(i,j,slice));
                elseif strcmp(part, 'imag')
                    total(slice) = total(slice) + imag(matrix(i,j,slice));
                elseif strcmp(part, 'abs')
                    total(slice) = total(slice) + abs(matrix(i,j,slice));
                else 
                    total(slice) = total(slice) + matrix(i,j,slice);
                end
            end
        end
        total = ( 1 / sizeMM(1)) .* total; %mean ervy variable
        for slice = 1 : num_param %store the mean of each variable
            meanLine(j, 1 + slice) = total(slice);
        end
    end
