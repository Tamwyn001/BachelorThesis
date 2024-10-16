set loadpath './gpscripts/'
load 'GapEq_HeatMapBase.gp'

splot dataroot."/20x20NoBC.dat" using ($1 - 0.5): ($2 - 0.5) : 3  with pm3d notitle palette
unset colorbox
set out
# pause -1
