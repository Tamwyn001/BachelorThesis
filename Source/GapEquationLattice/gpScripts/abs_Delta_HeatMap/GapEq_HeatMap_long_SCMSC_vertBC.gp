set loadpath './gpscripts/'
load '/abs_Delta_HeatMap/GapEq_HeatMap_long_SCMSC_Base.gp'

splot dataroot."/31x15VertBC.dat" using ($1 - 0.5): ($2 - 0.5) : 3  with pm3d notitle palette
unset colorbox
set out
# pause -1
