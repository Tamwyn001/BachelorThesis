set loadpath './gpscripts/'
load 'GapEq_HeatMapBase.gp'

unset xlabel
unset ylabel
set cbrange [-2e-5:1e-5]
unset ytics
splot dataroot."/20x20VertHorizBC.dat" using 1:2:3 with pm3d notitle palette
set out