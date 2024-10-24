function NeigboursMap(x, y)
    system = System();
    system = system.createLattice();

    map = zeros(system.Ny, system.Nx);
    id = system.points{1}.xy_to_i(x, y);
    for i = 1:system.Nx
        for j= 1:system.Ny
            if j == x && i == y 
                map(i, j) = 0.5;
            else
                [are_neigh, axe] = Neighbours(system.points{id}, system.points{system.points{id}.xy_to_i(j,i)}, system);
                if are_neigh && strcmp(axe, 'x')
                    map(i, j) = 1;
                elseif are_neigh && strcmp(axe, 'y')
                    map(i, j) = -1;
                else
                    map(i, j) = 0;
                end
            end
        end
    end
    heatmap(map);
end