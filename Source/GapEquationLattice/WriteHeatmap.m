function points = WriteHeatmap(system, to_write)
    points = strings(system.Ny*system.Nx+system.Nx,3);
    t = 0;
    for i = 1: numel(system.points)
        % disp([num2str(j) num2str(i) string(heat_map(j,i))])
        point = system.points{i};
        if strcmp(to_write, 'correl_c_c')
             attrib = string(abs(point.c_up_c_down));
        elseif strcmp(to_write, 'phase')
            attrib = string(angle(point.delta));
        end
        
        points(i+t, :) = [string(point.x), string(point.y), attrib];
        
        if mod(i,system.Nx) == 0
            points(i+t+1, :) = ["" "" ""];
            t = t+1;
        end
    end
end