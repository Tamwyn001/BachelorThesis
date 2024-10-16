set loadpath './gpScripts/'
load 'Currents_Base.gp'

unset label 1
unset label 2
unset arrow 1

materialY = 1.06

material1X = (( 10.0 + 1.0) /2.0 ) / 24.0
set label 3 'SC' at graph material1X, materialY center
material2X = ((14.0 + 11.0)/2.0)/24.0
set label 4 'AM' at graph material2X, materialY center
material3X = ((24.0 + 15.0)/2.0)/24.0
set label 5 'SC' at graph material3X, materialY center

x0 = 10.5
set arrow 2 from x0, graph 0 to x0, graph 1 nohead ls 1 # left dashed line 
x1 = 14.5
set arrow 3 from x1, graph 0 to x1, graph 1 nohead ls 1 #right dashed line
set xrange[0:25]
set yrange[0:25]
