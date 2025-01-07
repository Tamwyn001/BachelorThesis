function system = ComputeCurrents(system, computation)
    for i = 1: system.Nx * system.Ny
        I_x = 0.0;
        I_y = 0.0;
        target_site = system.points{i};
        Fermi = @(n) FermiDiarac(1*computation.E(n), system.T);
            for index_eigen = 1 : numel(computation.n) %sum over n, the numbers of eigenvectors with POSITIVE energies.
                n = computation.n(index_eigen);
                % make a if on is neigbour i : i-1 etc to avoid the vaccum
                [ui,vi] = computation.GetUVatI( i, n);

                %CanFindNeigbour(i, '-x', system);
                if ~isempty(target_site.neighbour{3}) 
                    %fprintf("Site %d has a neighbour %d in -x\n", i, target_site.neighbour{3}.i );
                    [uim1,vim1] = computation.GetUVatI( target_site.neighbour{3}.i, n);
                else
                    %fprintf("Site %d has no neighbour in -x\n", i);
                    uim1 = [0 0];
                    vim1 = [0 0];
                end

                %CanFindNeigbour(i, '+x', system);
                if ~isempty(target_site.neighbour{1}) 
                    %fprintf("Site %d has a neighbour %d in +x\n", i,  target_site.neighbour{1}.i);
                    [uip1,vip1] = computation.GetUVatI( target_site.neighbour{1}.i, n);

                else
                    %fprintf("Site %d has no neighbour in +x\n", i);
                    uip1 = [0 0];
                    vip1 = [0 0];
                end

                % CanFindNeigbour(i, '-y', system);
                if ~isempty(target_site.neighbour{4}) 
                    %fprintf("Site %d has a neighbour %d in -y\n", i,  target_site.neighbour{4}.i);
                    [uimN,vimN] = computation.GetUVatI( target_site.neighbour{4}.i, n);

                else
                    %fprintf("Site %d has no neighbour in -y\n", i);
                    uimN = [0 0];
                    vimN = [0 0];
                end


                % CanFindNeigbour(i, '+y', system);
                if ~isempty(target_site.neighbour{2}) 
                    %fprintf("Site %d has a neighbour %d in +y\n", i,  target_site.neighbour{2}.i);
                    [uipN,vipN] = computation.GetUVatI(target_site.neighbour{2}.i, n);
                else
                    %fprintf("Site %d has no neighbour in +y\n", i);
                    uipN = [0 0];
                    vipN = [0 0];
                end
    
                hopping_x = @(spin1, spin2) Fermi(n) * (ui(spin1)) * conj(uim1(spin1) - uip1(spin2))...
                    + (1 - Fermi(n)) * conj(vi(spin1)) * (vim1(spin1) - vip1(spin2)); 
                hopping_y = @(spin1, spin2) Fermi(n) * (ui(spin1)) * conj(uimN(spin1) - uipN(spin2))...
                    + (1 - Fermi(n)) * conj(vi(spin1)) * (vimN(spin1) - vipN(spin2)); 

                if strcmp(target_site.materialLayer, 'SC') || strcmp(target_site.materialLayer, 'AM')

                        I_x = I_x + imag(hopping_x(1,1) + hopping_x(2,2)) * system.t_ij ;
                        I_y = I_y + imag(hopping_y(1,1) + hopping_y(2,2)) * system.t_ij ;
                
                elseif strcmp(target_site.materialLayer, 'AM')
                    hopping_AM_x = @(spin1, spin2) Fermi(n) * (ui(spin1) * conj(uim1(spin1) - uip1(spin1))...
                                                        + conj(ui(spin1)) *     (uip1(spin2)- uim1(spin2)))...
                                      + (1 - Fermi(n)) * (conj(vi(spin1)) *     (vim1(spin1)- vip1(spin1)))...
                                                             + vi(spin1) * conj(vip1(spin2) - vim1(spin2));

                    hopping_AM_y = @(spin1, spin2) Fermi(n) * (ui(spin1) * conj(uimN(spin1) - uipN(spin1))...
                                                        + conj(ui(spin1)) *     (uipN(spin2)- uimN(spin2)))...
                                      + (1 - Fermi(n)) * (conj(vi(spin1)) *     (vimN(spin1)- vipN(spin1)))...
                                                             + vi(spin1) * conj(vipN(spin2) - vimN(spin2));
    

                    for spin2 = 1:2
                        I_x = I_x + 1/(2i) * (hopping_AM_x(1, spin2)* SystemBase.getMSigmaElem('x', 1, spin2) ...
                                           +  hopping_AM_x(2, spin2)* SystemBase.getMSigmaElem('x', 2, spin2)); %different hopping absed on the spin
                        I_y = I_y + 1/(2i) * (hopping_AM_y(1, spin2)* SystemBase.getMSigmaElem('y', 1, spin2) ...
                                           +  hopping_AM_y(2, spin2)* SystemBase.getMSigmaElem('y', 2, spin2));
                    end
                end

            end
    
        Console.progressBar(i, system.Nx * system.Ny);
        if ~isnan(I_x) && ~isnan(I_y)
            system.points{i}.current = [I_x I_y];
        else  
            system.points{i}.current = [0, 0];
            disp('Current is nan. Setting to 0');
        end
    end
end