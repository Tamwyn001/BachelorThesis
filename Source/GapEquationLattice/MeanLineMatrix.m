function  meanLine = MeanLineMatrix(matrix, part)

    sizeMM = size(matrix);
    sizesizeMM = size(sizeMM);
    if sizesizeMM(2) == 2
        num_param = 1;
    else
        num_param = sizeMM(3);
    end
    meanLine = zeros(sizeMM(2), num_param); %x and variables

    % A = fscanf(fileID,formatSpec,sizeA); 
    for j = 1 : sizeMM(2)
        meanLine(j,1) = j;
        total = zeros(num_param,1);
        for i = 1 : sizeMM(1)
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
        total(:) = total(:)/sizeMM(1);
        for slice = 1 : num_param
            meanLine(j,1 + slice) = total(slice);
        end
    end
