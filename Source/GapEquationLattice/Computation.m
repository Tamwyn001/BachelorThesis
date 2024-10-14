classdef Computation
    properties
        eigenvalues
        eigenvectors
        E
    end
    methods
        function obj = Computation(system)
            obj.eigenvalues = zeros(system.Nx*system.Ny*4,1);
            obj.eigenvectors = zeros(system.Nx*system.Ny*4,system.Nx*system.Ny*4);
        end
        function obj = writeNewEigen(obj, vector, val)
            obj.eigenvalues = val;
            obj.eigenvectors = vector;
            obj.E = diag(obj.eigenvalues);
        end
    end
end