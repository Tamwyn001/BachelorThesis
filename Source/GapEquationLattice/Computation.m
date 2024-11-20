classdef Computation
    properties
        eigenvalues
        eigenvectors
        E
        n
    end
    methods
        function obj = StorePositiveIndex(obj)
            obj.n = zeros(numel(obj.E)/2, 1);
            t = 1;
            for i = 1: numel(obj.E)

                if obj.E(i) < 0.0
                    obj.n(t) = i;
                    t = t + 1;
                end
                
            end
            % fprintf('%d %d\n', obj.E(obj.n(1)), obj.E(obj.n(numel(obj.E)/2)));
        end
        function [u,v] = GetUVatI(obj, i,n)
            u = [obj.eigenvectors(4*(i-1) + 1, n) , obj.eigenvectors(4*(i-1) + 2, n)]; %UP , DOWN
            v = [obj.eigenvectors(4*(i-1) + 3, n) , obj.eigenvectors(4*i, n)]; %UP , DOWN
        end


        function obj = Computation(system)
            obj.eigenvalues = zeros(system.Nx*system.Ny*4,1);
            obj.eigenvectors = zeros(system.Nx*system.Ny*4,system.Nx*system.Ny*4);
        end
        function obj = writeNewEigen(obj, vector, val)
            obj.eigenvalues = val;
            obj.eigenvectors = vector;
            obj.E = diag(obj.eigenvalues);
            obj = obj.StorePositiveIndex();
        end
    end
end