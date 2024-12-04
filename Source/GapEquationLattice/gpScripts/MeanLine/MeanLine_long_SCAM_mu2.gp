set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC10-AM10.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
#set yrange [-0.1:0.25]
plot [1:30] \
    dataroot.'/mu_delta_-1.75_0.06/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 1 lw 3.5 lc palette frac 0.2,\

set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
