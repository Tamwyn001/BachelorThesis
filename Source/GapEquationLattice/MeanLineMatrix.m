function  meanLine = MeanLineMatrix(matrix, part)

    sizeMM = (size(matrix));
    meanLine = zeros(sizeMM(2),2);

    % A = fscanf(fileID,formatSpec,sizeA); 
    for j = 1:sizeMM(2)
        meanLine(j,1) = j;
        total = double(0);
        for i = 1:sizeMM(1)
            if strcmp(part, 'real')
                total = total + real(matrix(i,j));
            elseif strcmp(part, 'imag')
                total = total + imag(matrix(i,j));
            elseif strcmp(part, 'abs')
                total = total + abs(matrix(i,j));
            else 
                total = total + matrix(i,j);
            end
        end
        meanLine(j,2) = total/double(sizeMM(1));
    end
