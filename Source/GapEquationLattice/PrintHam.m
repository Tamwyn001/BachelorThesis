function PrintHam(x,y, k_id,systemType)
    if strcmp(systemType, 'Fourier')
        system = SystemFourier();
        system = system.createLattice();
        system = system.generateHam(true);
    else
        system = System();
        system = system.createLattice();
        system = system.generateHam();
    end
    
    if nargin == 1
        disp(system.hamiltonian);
    return
    elseif nargin == 2
        result = strings(system.Nx, system.Ny);
        for i = 1:system.Nx *system.Ny
            point = system.points{i};
            fprintf('%d,%d: %s\n', point.x, point.y, point.materialLayer);
            result(point.y, point.x) = point.materialLayer;
        end
        disp(result);
    return
    else
        if x == y
            fprintf('Hamiltonian for a %s at location (x,y)=(%d,%d)\n', system.points{x}.materialLayer, system.points{x}.x, system.points{x}.y);
        else
            [neighbours, axe] = Neighbours(system.points{x}, system.points{y}, system);
            if neighbours
                info = sprintf('neighbours on axe %s', axe);
            else
                info = 'non neighbours';
            end
            fprintf('Hamiltonian for the interaction between %s, a %s and a %s\n',info, system.points{x}.materialLayer, system.points{y}.materialLayer);
        end
        if isa(system, 'System')
            disp(system.hamiltonian(4*(x-1) + 1: 4*(x-1) + 4, 4*(y-1) + 1: 4*(y-1) + 4));
        elseif isa(system, 'SystemFourier')
            disp(system.hamiltonian(2*(x-1) + 1: 2*(x-1) + 2, 2*(y-1) + 1: 2*(y-1) + 2, k_id));
        end
    end
end