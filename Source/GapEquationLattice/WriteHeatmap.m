function points = WriteHeatmap(system, to_write)
    points = strings(system.Ny*system.Nx+system.Nx,3);
    t = 0;
    for i = 1: numel(system.points)
        % disp([num2str(j) num2str(i) string(heat_map(j,i))])
        point = system.points{i};
        if strcmp(to_write, 'correl_c_c')
             attrib = string(abs(point.c_up_c_down));
        elseif num2str(to_write, 'phase')
            attrib = num2str(angle(point.delta));
        elseif strcmp(to_write, 'continuity')
            cont_X = GetCurrentOfNeigbour(system.points{i}.neighbour{1}, 'x') - GetCurrentOfNeigbour(system.points{i}.neighbour{3}, 'x');
            cont_Y = GetCurrentOfNeigbour(system.points{i}.neighbour{2}, 'y') - GetCurrentOfNeigbour(system.points{i}.neighbour{4}, 'y');
            attrib = num2str(cont_X + cont_Y);
        end
        
        points(i+t, :) = [string(point.x), string(point.y), attrib];
        
        if mod(i,system.Nx) == 0
            points(i+t+1, :) = ["" "" ""];
            t = t+1;
        end
    end
end