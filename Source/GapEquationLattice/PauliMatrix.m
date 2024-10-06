classdef PauliMatrix
    properties (Constant)
        % Define the Pauli matrices as constant properties
        sigmaX = [1i, 0; 0, 1i];  % Pauli X
        sigmaY = [0, -1i; 1i, 0];  % Pauli Y
        sigmaZ = [1, 0; 0, -1];  % Pauli Z
        identity = [1, 0; 0, 1];  % Identity matrix
    end

    methods (Static)
        % Method to retrieve a specific Pauli matrix by name
        function matrix = getPauli(name)
            switch name
                case 'X'
                    matrix = PauliMatrix.sigmaX;
                case 'Y'
                    matrix = PauliMatrix.sigmaY;
                case 'Z'
                    matrix = PauliMatrix.sigmaZ;
                case 'I'
                    matrix = PauliMatrix.identity;
                otherwise
                    error('Unknown Pauli matrix. Choose from X, Y, Z, or I.');
            end
        end
    end
end
