set loadpath './gpscripts/'
load 'GapEq_HeatMapBase.gp'

unset label 1
unset label 2
unset arrow 1

set mxtics 5
set mytics 5

materialY = 1.06

material1X = (( 10.0 + 1.0) /2.0 ) / 24.0
set label 3 'SC' at graph material1X, materialY center
material2X = ((14.0 + 11.0)/2.0)/24.0
set label 4 'AM' at graph material2X, materialY center
material3X = ((24.0 + 15.0)/2.0)/24.0
set label 5 'SC' at graph material3X, materialY center



set xrange[0.5 : 23.5]
set yrange[0.5 : 23.5]
# pause -1
