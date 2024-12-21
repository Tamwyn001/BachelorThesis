function PrintHam(x,y, k_id, systemType,tilted)
    if nargin == 2
        type = x;
        tilt = y;
    else
        type = systemType;
        tilt = tilted;
    end
    if strcmp(type, 'Fourier')
        system = SystemFourier();
        system = system.createLattice();
        system = system.generateHam(true);
    elseif strcmp(type, 'DWave')
            system = System_DWave();
            system = system.createLattice(tilt);
            system = system.generateHam();
    else
        system = System();
        system = system.createLattice(tilt);
        system = system.generateHam();
    end
    
    if nargin == 2
        heatmap(system.hamiltonian);
        disp(system.hamiltonian);
    return
    elseif nargin == 3
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