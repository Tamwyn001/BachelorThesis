set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC10-AM10.cfg'
load '/MeanLine/MeanLine_Base.gp'

set ylabel '$\nabla \cdot \bm{I}$'
unset logscale y
#set yrange[-50:200]
dataroot = './Results'.targetSystem
set yrange [-6e-4:6e-4]
plot [1:30] \
    dataroot.'/meanline_Continuity_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\mu = -1.75$' dashtype 3 lw 3 lc palette frac 0.2
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
