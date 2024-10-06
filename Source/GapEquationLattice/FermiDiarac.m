function f = FermiDiarac(E,T, mu)
%FERMIDIARAC Summary of this function goes here
%   Detailed explanation goes here
    % Constants
    k_B = 8.617333262145e-5; % Boltzmann constant in eV/K
    
    % Fermi-Dirac distribution
    f = 1 ./ (exp((E - mu) ./ (k_B * T)) + 1);
end

