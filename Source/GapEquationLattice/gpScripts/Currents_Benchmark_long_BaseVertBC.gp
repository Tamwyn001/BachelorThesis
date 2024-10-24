set loadpath './gpScripts/'
load 'Currents_Base.gp'

unset label 1
unset label 2
unset arrow 1
set xrange [0:31]
set yrange [0:16]
set size ratio 0.5 #30/15 ratio
plot dataroot.'/current_30x15VertBC.dat' \
    using ($1 - dx($3,$4)/(2)) : ($2 - dy($3,$4)/(2)) : (dx($3,$4)) : (dy($3,$4)) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle
