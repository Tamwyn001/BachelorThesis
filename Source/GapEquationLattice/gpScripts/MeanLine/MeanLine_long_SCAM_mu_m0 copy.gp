set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC10-AM10.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
#set yrange [-0.1:0.25]
plot [1:45] \
    dataroot.'/SC15AM30_m0/NotFourier/FreeDelta/diffMU/-1.75/meanline_45x10NoBC.dat' using 1:2 with lines title '\footnotesize -1.75 m0' dashtype 1 lw 4 lc palette frac 0.6,\
    dataroot.'/SC15AM30_m0.5/NotFourier/FreeDelta/diffMU/-1.75/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize -1.75 m0.5' dashtype 3 lw 4 lc palette frac 0.2,\


set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
