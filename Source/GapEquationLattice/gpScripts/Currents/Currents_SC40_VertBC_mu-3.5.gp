set loadpath './gpScripts/'

load '/SystemDesc/SC.cfg'
load '/Currents/Currents_Base.gp'

contrast = 1.0
scale = 1.2*10000.0
len = 4.0
set xrange [0:41]
set yrange [0:31]
plot dataroot.'/current_40x30NoBC.dat' \
    using ($1 - dx($3,$4)/(2)*logarrow($3,$4)) : ($2 - dy($3,$4)/(2)*logarrow($3,$4)) : (dx($3,$4)*logarrow($3,$4)) : (dy($3,$4)*logarrow($3,$4)) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle

set out