function  meanLine = MeanLineMatrix(matrix)
    % fileID = fopen(path,'r');
    % formatSpec = '%f %f';
    % sizeA = [size size];
    sizeMM = (size(matrix));
    sizeM = sizeMM(1);
    meanLine = zeros(sizeM,2);

    % A = fscanf(fileID,formatSpec,sizeA); 
    for j = 1:sizeM
        meanLine(j,1) = j;
        total = double(0);
        for i = 1:sizeM
            total = total + matrix(i,j);
        end
        meanLine(j,2) = total/double(sizeM);
    end
    % [filepath,name,ext]= fileparts(path);
    % out_path= strcat(filepath,'\meanLine_', name,'.dat');
    % writematrix(meanLine, out_path,'Delimiter',';')
    % fclose(fileID);