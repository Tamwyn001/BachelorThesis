set loadpath './gpScripts/'
load '/SystemDesc/SC13-AM5-SC13.cfg'
load '/abs_Delta_HeatMap/GapEq_HeatMapBase.gp';


unset label 1
unset label 2
unset arrow 1

set mxtics 5
set mytics 5

materialY = 1.06


set xrange[0.5 : 23.5]
set yrange[0.5 : 23.5]
# pause -1
