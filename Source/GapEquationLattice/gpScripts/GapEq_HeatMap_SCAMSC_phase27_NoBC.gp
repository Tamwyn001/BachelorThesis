set loadpath './gpscripts/'
load 'GapEq_HeatMap_SCAMSC_basePhase_NoBC.gp'


set cbrange [0 : 4e-6]

splot dataroot."/24x24NoBC.dat" using 1:2:3 with pm3d notitle palette
unset colorbox
set out
# pause -1
