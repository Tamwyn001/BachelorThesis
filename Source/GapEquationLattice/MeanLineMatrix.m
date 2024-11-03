function  meanLine = MeanLineMatrix(matrix)

    sizeMM = (size(matrix));
    meanLine = zeros(sizeMM(2),2);

    % A = fscanf(fileID,formatSpec,sizeA); 
    for j = 1:sizeMM(2)
        meanLine(j,1) = j;
        total = double(0);
        for i = 1:sizeMM(1)
            total = total + matrix(i,j);
        end
        meanLine(j,2) = total/double(sizeMM(1));
    end
