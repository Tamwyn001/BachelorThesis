set loadpath './gpscripts/'
load '/Phase_Delta_HeatMap/Phase_HeatMap_Base.gp'

set xrange [0.5:29.5]
set yrange [0.5:14.5]
splot dataroot."/Phase_30x15NoBC.dat" using ($1 - 0.5): ($2 - 0.5) : ($3*180/pi) with pm3d notitle palette
set out
