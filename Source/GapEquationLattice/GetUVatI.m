function [u,v] = GetUVatI(computation, i,n)
    u = [computation.eigenvectors(4*(i-1) + 1, n) , computation.eigenvectors(4*(i-1) + 2, n)]; %UP , DOWN
    v = [computation.eigenvectors(4*(i-1) + 3, n) , computation.eigenvectors(4*i, n)]; %UP , DOWN
end