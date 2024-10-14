function system = ComputeCurrents(system, computation)
    for i = 1: system.Nx * system.Ny
        I_x = 0.0;
        I_y = 0.0;
        target_site = system.points{i};
        
            for n = 1: numel(computation.E)
                % make a if on is neigbour i : i-1 etc to avoid the vaccum
                [ui,vi] = GetUVatI(computation, i, n);

                %[mx_cond, mx_id] = CanFindNeigbour(i, '-x', system);
                if ~isempty(target_site.neighbour{3}) 
                    %fprintf("Site %d has a neighbour %d in -x\n", i, target_site.neighbour{3}.i );
                    [uim1,vim1] = GetUVatI(computation,  target_site.neighbour{3}.i, n);
                else
                    %fprintf("Site %d has no neighbour in -x\n", i);
                    uim1 = [0 0];
                    vim1 = [0 0];
                end

                %[px_cond, px_id] = CanFindNeigbour(i, '+x', system);
                if ~isempty(target_site.neighbour{1}) 
                    %fprintf("Site %d has a neighbour %d in +x\n", i,  target_site.neighbour{1}.i);
                    [uip1,vip1] = GetUVatI(computation,  target_site.neighbour{1}.i, n);

                else
                    %fprintf("Site %d has no neighbour in +x\n", i);
                    uip1 = [0 0];
                    vip1 = [0 0];
                end

                %[my_cond, my_id] = CanFindNeigbour(i, '-y', system);
                if ~isempty(target_site.neighbour{4}) 
                    %fprintf("Site %d has a neighbour %d in -y\n", i,  target_site.neighbour{4}.i);
                    [uimN,vimN] = GetUVatI(computation,  target_site.neighbour{4}.i, n);

                else
                    %fprintf("Site %d has no neighbour in -y\n", i);
                    uimN = [0 0];
                    vimN = [0 0];
                end


                %[py_cond, py_id] = CanFindNeigbour(i, '+y', system);
                if ~isempty(target_site.neighbour{2}) 
                    %fprintf("Site %d has a neighbour %d in +y\n", i,  target_site.neighbour{2}.i);
                    [uipN,vipN] = GetUVatI(computation, target_site.neighbour{2}.i, n);
                else
                    %fprintf("Site %d has no neighbour in +y\n", i);
                    uipN = [0 0];
                    vipN = [0 0];
                end
                hopping_x = @(spin) (conj(uip1(spin))- conj(uim1(spin))) * ui(spin) + (conj(vip1(spin))- conj(vim1(spin))) * vi(spin); 
                hopping_y = @(spin) (conj(uimN(spin))- conj(uipN(spin))) * ui(spin) + (conj(vimN(spin))- conj(vipN(spin))) * vi(spin); 

                I_x = I_x + (hopping_x(1) + hopping_x(2))* system.t_ij * FermiDiarac(0.5 * computation.E(n), system.T, system.mu);
                I_y = I_y + (hopping_y(1) + hopping_y(2))* system.t_ij * FermiDiarac(0.5 * computation.E(n), system.T, system.mu);
                 
                if strcmp(target_site.materialLayer, 'AM')
                    plusXspin = @(spin) ((System.getMSigmaElem('x', spin, 1) + System.getMSigmaElem('x', spin, 2))... %in + x
                        * (ui(spin) * conj(uip1(spin)) - uim1(spin) * conj(ui(spin)))...
                        + (System.getMSigmaElem('x', spin, 1) + System.getMSigmaElem('x', spin, 2))... %in - x
                        * (uip1(spin) * conj(ui(spin)) - ui(spin) * conj(uim1(spin))))...
                        * (1 - FermiDiarac(computation.E(n), system.T, system.mu))...%---------------------
                        + ((System.getMSigmaElem('y', spin, 1) + System.getMSigmaElem('y', spin, 2))... %in + y
                        * (conj(vi(spin))*vip1(spin) - conj(vim1(spin))*vi(spin))...
                        + (System.getMSigmaElem('y', spin, 1) + System.getMSigmaElem('y', spin, 2))... %in - y
                        * (conj(vip1(spin))*vi(spin) - conj(vi(spin))*vim1(spin)))...
                        * FermiDiarac(computation.E(n), system.T, system.mu);
                        
                    plusYspin = @(spin) ((System.getMSigmaElem('x', spin, 1) + System.getMSigmaElem('x', spin, 2))... %in + x
                        * (ui(spin) * conj(uipN(spin)) - uimN(spin) * conj(ui(spin)))...
                        + (System.getMSigmaElem('x', spin, 1) + System.getMSigmaElem('x', spin, 2))... %in - x
                        * (uipN(spin) * conj(ui(spin)) - ui(spin) * conj(uimN(spin))))...
                        * (1 - FermiDiarac(computation.E(n), system.T, system.mu))...%---------------------
                        + ((System.getMSigmaElem('y', spin, 1) + System.getMSigmaElem('y', spin, 2))... %in + y
                        * (conj(vi(spin))*vipN(spin) - conj(vimN(spin))*vi(spin))...
                        + (System.getMSigmaElem('y', spin, 1) + System.getMSigmaElem('y', spin, 2))... %in - y
                        * (conj(vipN(spin))*vi(spin) - conj(vi(spin))*vimN(spin))...
                        * FermiDiarac(computation.E(n), system.T, system.mu));

                    disp(plusXspin(1)+ plusXspin(2));
                    I_x = I_x + plusXspin(1) + plusXspin(2);
                    I_y = I_y + plusYspin(1) + plusYspin(2);
                end
            end

        system.points{i}.current = [I_x I_y];
    end
end