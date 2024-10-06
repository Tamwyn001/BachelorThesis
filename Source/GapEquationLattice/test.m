function test()
    matrix = zeros(4);
    i=1;
    matrix(i:i+3, i:i+3) = eye(4);
    disp(matrix);