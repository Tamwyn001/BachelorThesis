set loadpath './gpScripts/'
load 'Currents_SCAMSC_Base.gp'


scale = 4
plot dataroot.'/current_24x24NoBC.dat' \
    u ($1 - dx($3,$4)/2 * logarrow($3,$4)) : ($2 - dy($3,$4)/2* logarrow($3,$4)) : (dx($3,$4)* logarrow($3,$4)) : (dy($3,$4)* logarrow($3,$4)) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle
