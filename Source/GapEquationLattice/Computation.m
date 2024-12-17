classdef Computation
    properties
        eigenvalues
        eigenvectors
        E
        n
    end
    methods

        function obj = Computation(system)
            if isa(system, 'System')
                size = system.Nx * system.Ny * 4;
            elseif isa(system, 'SystemFourier')
                size = system.Nx*2 ;
            end

            obj.eigenvalues = zeros(size,1);
                obj.eigenvectors = zeros(size, size);
        end

        function obj = StorePositiveIndex(obj)
            size_e = size(obj.E, 2); %E(n) or E(n,k) for the Fourier case
            if size_e == 1
                t = 1;
                for i = 1: numel(obj.E)
                    if obj.E(i) > 0.0
                        obj.n(t) = i;
                        t = t + 1;
                        %fprintf('E at %d = %.5f\n',i ,obj.E(i));
                    end
                end
                assert(numel(obj.n) == numel(obj.E)/2, 'Energies not evenly distributed, please check your hamiltonian.');   
            else
                obj.n = 0; % here we dont need to sort out the indicies because we sum over all n.
            end

        end
        function [u,v] = GetUVatI(obj, i,n)
            u = [obj.eigenvectors(4*(i-1) + 1, n) , obj.eigenvectors(4*(i-1) + 2, n)]; %UP , DOWN
            v = [obj.eigenvectors(4*(i-1) + 3, n) , obj.eigenvectors(4*i, n)]; %UP , DOWN
            

        end

        function [u,v] = GetUVatXK(obj, x, n, k)
            if  (x <= 0) || (x > size(obj.E, 1)/2 ) %we look to a x not in the system
                u= 0.0;
                v= 0.0;
                %assert(false, sprintf('x = %d is not in the system', x));
            return;
            end
            u = obj.eigenvectors(2*(x - 1) + 1, n, k); %UP , DOWN (xnk)
            v = obj.eigenvectors(2*(x - 1) + 2, n, k); %UP , DOWN (xnk)
        end



        function obj = writeNewEigen(obj, vector, val)
            obj.eigenvalues = val;

            obj.eigenvectors = vector;
            size_e = size(obj.eigenvalues);
            if numel(size_e) == 2
                obj.E = diag(obj.eigenvalues); %size is 4Nxny x 4Nxny
                obj.E(:) = real(obj.E(:));
            elseif numel(size_e) == 3
                for k_id = 1 : size_e(3)
                    obj.E(:, k_id) = diag(obj.eigenvalues(:, :, k_id)); % size is 2Nx x 2Nx x Ny
                end   
            end

            obj = obj.StorePositiveIndex();
            for n_id = 1: numel(obj.n)
                assert(isreal(obj.E(obj.n(n_id))), 'Eigenvalues are not real');
            end
            %disp(obj.E);
        end
    end
end