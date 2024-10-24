set loadpath './gpscripts/'
load 'GapEq_HeatMap_Long_SC_base.gp'

splot dataroot."/30x15NoBC.dat" using ($1 - 0.5): ($2 - 0.5) : 3  with pm3d notitle palette
unset colorbox
set out
# pause -1
