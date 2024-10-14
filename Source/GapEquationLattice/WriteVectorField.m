function FIELD = WriteVectorField(system)
    FIELD = strings(system.Ny*system.Nx+system.Nx,4);
    for i = 1: numel(system.points)
        % disp([num2str(j) num2str(i) string(heat_map(j,i))])
        point = system.points{i};
        FIELD(i, :) = [string(point.x), string(point.y), string(point.current(1)) string(point.current(2))];
    end
    return;
end