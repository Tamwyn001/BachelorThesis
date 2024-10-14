set loadpath './gpScripts/'
load 'Currents_Base.gp'

plot dataroot.'/current_20x20NoBC.dat' \
    u ($1 - dx($3,$4)/2 * logarrow($3,$4)) : ($2 - dy($3,$4)/2* logarrow($3,$4)) : (dx($3,$4)* logarrow($3,$4)) : (dy($3,$4)* logarrow($3,$4)) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle
