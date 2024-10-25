set loadpath './gpScripts/'
load '/abs_Delta_HeatMap/GapEq_HeatMap_squared_SCAM_Base.gp'


# set cbrange [-2e-5:1e-5]
splot dataroot."/20x20VertBC.dat" using ($1 - 0.5): ($2 - 0.5) : 3  with pm3d notitle palette
unset colorbox
set out
