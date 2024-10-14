function FindMap(i,j)
    system = System();
    system = system.createLattice();
    result = zeros(system.Ny, system.Nx);
    [found, loc] = CanFindNeigbour(i, j, system);
    disp(found);
    result(system.points{i}.y, system.points{i}.x) = 2;
    if ~found
        heatmap(result);
        return;
    end
    for m = 1: numel(system.points)
        point = system.points{m};
        if point.i == loc
            result(point.y, point.x) = 1;
        end
    end
    heatmap(result);
    return;
end