function val = GetCurrentOfNeighbour(point,axis) % this is normalised on the lattice site!
    if isempty(point)
        val = 0.0;
        return;
    end
    if strcmp(axis, 'x')
        val = point.current(1);
    elseif strcmp(axis, 'y')
        val = point.current(2);
    else
        val = 0.0;
    end
