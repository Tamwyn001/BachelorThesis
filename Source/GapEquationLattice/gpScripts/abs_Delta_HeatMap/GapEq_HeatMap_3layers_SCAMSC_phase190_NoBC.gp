set loadpath './gpscripts/'
load '/abs_Delta_HeatMap/GapEq_HeatMap_3layers_SCAMSC_basePhase_NoBC.gp'


set cbrange [0 : 2e-6]
splot dataroot."/24x24NoBC.dat" using ($1 - 0.5): ($2 - 0.5) : 3 with pm3d notitle palette
unset colorbox
set out
# pause -1
