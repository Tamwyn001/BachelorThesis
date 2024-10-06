function PrintHam(x,y)
    system = System();
    system = system.createLattice();
    system = system.generateHam();
    if nargin == 0
        disp(system.hamiltonian);
    return
    elseif nargin == 1
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
        disp(system.hamiltonian(4*(x-1) + 1: 4*(x-1) + 4, 4*(y-1) + 1: 4*(y-1) + 4));
    end
end