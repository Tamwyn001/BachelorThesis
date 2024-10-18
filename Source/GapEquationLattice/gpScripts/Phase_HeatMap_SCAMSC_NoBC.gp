set loadpath './gpscripts/'
load 'GapEq_HeatMap_SCAMSC_basePhase_NoBC.gp'

set cbrange [-180:180]
set cbtics format "{\\tiny %.0f°}" 
x0 = 10.5
set arrow 2 from x0, graph 1 to x0, graph 1.1 nohead ls 1 # left dashed line 
x1 = 14.5
set arrow 3 from x1, graph 1 to x1, graph 1.1 nohead ls 1 #right dashed line
splot dataroot."/Phase_24x24NoBC.dat" using ($1 - 0.5): ($2 - 0.5) : ($3*180/pi) with pm3d notitle palette


unset colorbox
set out
# pause -1
