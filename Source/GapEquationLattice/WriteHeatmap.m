function points = WriteHeatmap(system)
    points = strings(system.Ny*system.Nx+system.Nx,3);
    t = 0;
    for i = 1: numel(system.points)
        % disp([num2str(j) num2str(i) string(heat_map(j,i))])
        point = system.points{i};
        points(i+t, :) = [string(point.x), string(point.y), string(abs(point.delta))];
        
        if mod(i,system.Nx) == 0
            points(i+t+1, :) = ["" "" ""];
            t = t+1;
        end
    end
end