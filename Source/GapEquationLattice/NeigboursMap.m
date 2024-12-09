function NeigboursMap(x, y)
    system = System();
    system = system.createLattice(false);

    map = zeros(system.Ny, system.Nx);
    
    id = system.xy_to_i(x, y);
    map(y, x) = 2;
    if ~isempty(system.points{id}.neighbour{1})
        map(system.points{id}.neighbour{1}.y, system.points{id}.neighbour{1}.x) = 0.5;
    end
    if ~isempty(system.points{id}.neighbour{2})
        map(system.points{id}.neighbour{2}.y, system.points{id}.neighbour{2}.x) = 1;
    end
    if ~isempty(system.points{id}.neighbour{3})
        map(system.points{id}.neighbour{3}.y, system.points{id}.neighbour{3}.x) = 0.5;
    end
    if ~isempty(system.points{id}.neighbour{4})
        map(system.points{id}.neighbour{4}.y, system.points{id}.neighbour{4}.x) = 1;
    end
    % id = system.points{1}.xy_to_i(x, y);
    % for i = 1:system.Nx
    %     for j= 1:system.Ny
    %         if i == x && j == y 
    %             map(j, i) = 0.5;
    %         else
    %             fprintf('location at x %d, y %d   gives i %d\n', i, j ,system.points{id}.xy_to_i(i,j));
    %             [are_neigh, axe] = Neighbours(system.points{id}, system.points{system.points{id}.xy_to_i(i,j)}, system);
    %             if are_neigh && strcmp(axe, 'x')
    %                 map(j, i) = 1;
    %             elseif are_neigh && strcmp(axe, 'y')
    %                 map(j, i) = -1;
    %             else
    %                 map(j, i) = 0;
    %             end
    %         end
    %     end
    % end
    heatmap(map);
end