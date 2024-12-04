set loadpath './gpScripts/'

load '/SystemDesc/SC12-AM6-SC12.cfg'
load '/Currents/Currents_Base.gp'
unset label 1
unset label 2
unset arrow 1
set xrange [0:31]
set yrange [0:16]
set size ratio 0.5 #30/15 ratio
set colorbox vertical user origin graph 1.025, 0.0 size 0.035, 0.8
contrast = 0.6
scale = 1*10000.0
plot [0:31] dataroot.'/current_30x15VertBC.dat' \
    using ($1 - dx($3,$4)/(2)*logarrow($3,$4)) : ($2 - dy($3,$4)/(2)*logarrow($3,$4)) : (dx($3,$4)*logarrow($3,$4)) : (dy($3,$4)*logarrow($3,$4)) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle

set out