function points = WriteHeatmap(system, to_write)
    
    if strcmp(to_write, 'continuity')
        points = strings(system.Ny*system.Nx+system.Nx,4);
    else
        points = strings(system.Ny*system.Nx+system.Nx,3);
    end
    t = 0;
    for i = 1: numel(system.points)
        % disp([num2str(j) num2str(i) string(heat_map(j,i))])
        point = system.points{i};
        if strcmp(to_write, 'Delta_d')
            attrib1 = num2str(abs(point.F_d));
            attrib2 = num2str(angle(point.F_d));
            points(i+t, :) = [string(point.x), attrib1, attrib2];
        else
            if strcmp(to_write, 'correl_c_c')
                attrib = string(abs(point.c_up_c_down));
                points(i+t, :) = [string(point.x), string(point.y), attrib];
            elseif strcmp(to_write, 'correl_c_c_RE')   
                attrib = string(real(point.c_up_c_down));
                points(i+t, :) = [string(point.x), string(point.y), attrib];
            elseif strcmp(to_write, 'correl_c_c_IM')
                attrib = string(imag(point.c_up_c_down));
                points(i+t, :) = [string(point.x), string(point.y), attrib];
            elseif strcmp(to_write, 'phase')
                attrib = num2str(angle(point.delta));
                points(i+t, :) = [string(point.x), string(point.y), attrib];
            elseif strcmp(to_write, 'continuity')
                cont_X = (GetCurrentOfNeighbour(system, point.neighbour{1}, 'x') - GetCurrentOfNeighbour(system, point.neighbour{3}, 'x'))/2;
                cont_Y = (GetCurrentOfNeighbour(system, point.neighbour{2}, 'y') - GetCurrentOfNeighbour(system, point.neighbour{4}, 'y'))/2;
                %attrib = num2str(cont_X + cont_Y);
                points(i+t, :) = [string(point.x), string(point.y), num2str(cont_X), num2str(cont_Y)];
            end
            

        end
        
        
        
        if mod(i, system.Nx) == 0
            if strcmp(to_write, 'continuity')
                points(i+t+1, :) = ["", "", "", ""];
            else
                points(i+t+1, :) = ["", "", ""];
            end
            
            t = t+1;
        end
    end
end