set loadpath './gpScripts/'
load 'Currents/Currents_3layers_SCAMSC_Base.gp'

plot dataroot.'/current_31x15VertBC.dat' \
    using ($1 - dx($3,$4)/(2)) : ($2 - dy($3,$4)/(2)) : (dx($3,$4)) : (dy($3,$4)) : (enorm($3,$4)) \
    with vectors head size 0.5,20,60 filled lc palette notitle
