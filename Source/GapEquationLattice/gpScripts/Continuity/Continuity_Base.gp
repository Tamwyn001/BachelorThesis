set loadpath './gpScripts/'
load 'abs_Delta_HeatMap/GapEq_HeatMapBase.gp'
set cbtics format "{\\tiny \\(%.2te{%+03T}\\)}" 

set xrange [0.5:29.5] # from 1 to 30 shifted for the 3D verticies
set yrange [0.5:14.5] # from 1 to 15 shifted for the 3D verticies

splot dataroot."/continuity_30x15NoBC.dat" using ($1 - 0.5): ($2 - 0.5) : 3 with pm3d notitle palette
