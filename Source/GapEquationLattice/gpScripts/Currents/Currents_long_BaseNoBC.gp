set loadpath './gpScripts/'
load '/Currents/Currents_Base.gp'

unset label 1
unset label 2
unset arrow 1
set xrange [0:31]
set yrange [0:16]
set size ratio 0.5 #30/15 ratio
set colorbox vertical user origin 0.99, 0.1 size 0.02,0.8
plot dataroot.'/current_30x15NoBC.dat' \
    using ($1 - dx($3,$4)/(2)*logarrow(v1,v2)) : ($2 - dy($3,$4)/(2)*logarrow(v1,v2)) : (dx($3,$4))*logarrow(v1,v2) : (dy($3,$4))*logarrow(v1,v2) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle
