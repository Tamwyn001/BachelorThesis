set loadpath './gpscripts/'
load 'GapEq_HeatMapBase.gp'

unset label 1
unset label 2
unset arrow 1

set mxtics 5
set mytics 2
set xrange [0.5:29.5]
set yrange [0.5:14.5]
materialY = 1.06
set size ratio 0.5 #30/15 ratio
set cbrange [-180:180]
set cbtics format "{\\tiny %.0f°}" 
splot dataroot."/Phase_30x15VertBC.dat" using ($1 - 0.5): ($2 - 0.5) : ($3*180/pi) with pm3d notitle palette

unset colorbox
set out
# pause -1
