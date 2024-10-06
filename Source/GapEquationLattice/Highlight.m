function Highlight(type)
    system = System();
    system = system.createLattice();
    target_info = "";
    if nargin ~= 0
        switch (type)
            case "SC" 
                target_info = "material";
            case "AM"
                target_info = "material";
            otherwise
                target_info = "type";
                return
        end
    end
    map = zeros(system.Nx, system.Ny);
    for i = 1:system.Nx*system.Ny
        if strcmp(target_info, "type") 
            if strcmp(system.points{i}.type, type)
                map(system.points{i}.y, system.points{i}.x) = 1 ;
            end
        elseif strcmp(target_info, "material")
            if strcmp(system.points{i}.materialLayer, type)
                map(system.points{i}.y, system.points{i}.x) = 1 ;
            end
        end
    end
    heatmap(map);
end