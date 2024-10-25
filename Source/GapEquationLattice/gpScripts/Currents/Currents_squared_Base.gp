set loadpath './gpScripts/'
load '/Currents/Currents_Base.gp'

unset label 1
unset label 2
unset arrow 1

set xrange [0:21] # 20x20
set yrange [0:21] # 20x20

set size ratio 1
plot dataroot.'/current_20x20NoBC.dat' \
    u ($1 - dx($3,$4)/2 * logarrow($3,$4)) : ($2 - dy($3,$4)/2* logarrow($3,$4)) : (dx($3,$4)* logarrow($3,$4)) : (dy($3,$4)* logarrow($3,$4)) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle
