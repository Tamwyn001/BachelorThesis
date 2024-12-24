set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC15-AM30.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
#set yrange [-0.1:0.25]
plot [1:45] \
    dataroot.'/-1.75/meanline_45x10NoBC.dat' using 1:2 with lines title '\footnotesize 10' dashtype 1 lw 4 lc palette frac 0.0,\
    dataroot.'/-1.75/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize 15' dashtype 1 lw 4 lc palette frac 0.4,\
    dataroot.'/-1.75/meanline_45x20NoBC.dat' using 1:2 with lines title '\footnotesize 20' dashtype 1 lw 4 lc palette frac 0.8,\
    dataroot.'/-1.75/meanline_45x30NoBC.dat' using 1:2 with lines title '\footnotesize 30' dashtype 1 lw 4 lc palette frac 1,\

set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
