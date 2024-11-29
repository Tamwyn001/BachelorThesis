function system = ComputeCurrents(system, computation)
    for i = 1: system.Nx * system.Ny
        I_x = 0.0;
        I_y = 0.0;

        altermagnHopp = @(spin, axis) SystemBase.getMSigmaElem(axis, spin, 1) + SystemBase.getMSigmaElem(axis, spin, 2);
        target_site = system.points{i};
        
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
    
             % OWN MODEL : derivated on the notes
                hopping_x = @(spin) (ui(spin) * conj(uip1(spin) - uim1(spin)) + conj(ui(spin)) * (uim1(spin) - uip1(spin))) ...
                    * FermiDiarac(1*computation.E(n), system.T)...
                    + ( conj(vi(spin)) * (vip1(spin) - vim1(spin)) + vi(spin) * conj(vim1(spin) - vip1(spin)))...
                    * (1 - FermiDiarac(1*computation.E(n), system.T));
            
                hopping_y =  @(spin) (ui(spin) * conj(uipN(spin) - uimN(spin)) + conj(ui(spin)) * (uimN(spin) - uipN(spin))) ...
                    * FermiDiarac(1*computation.E(n), system.T)...
                    + ( conj(vi(spin)) * (vipN(spin) - vimN(spin)) + vi(spin) * conj(vimN(spin) - vipN(spin)))...
                    * (1 - FermiDiarac(1*computation.E(n), system.T));
            
                if strcmp(target_site.materialLayer, 'SC')

                        I_x = I_x + imag(hopping_x(1) + hopping_x(2)) * system.t_ij ;
                        I_y = I_y + imag(hopping_y(1) + hopping_y(2)) * system.t_ij ;
                elseif strcmp(target_site.materialLayer, 'AM')

                        I_x = I_x + imag(hopping_x(1) * altermagnHopp(1, 'x') + hopping_x(2) * altermagnHopp(2, 'x')); %different hopping absed on the spin
                        I_y = I_y + imag(hopping_y(1) * altermagnHopp(1, 'y') + hopping_y(2) * altermagnHopp(2, 'y'));

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