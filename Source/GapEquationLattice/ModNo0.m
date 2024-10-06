function i = ModNo0(x, y)
    m = mod(x,y);
    if m == 0
        i = y;
    else
        i = m;
    end
end