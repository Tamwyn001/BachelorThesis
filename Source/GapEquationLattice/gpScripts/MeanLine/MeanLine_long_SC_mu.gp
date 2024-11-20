set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'
set key outside right # Places the legend to the right of the plot area
set key at graph 1.6, 0 # Adjusts the legend position on the x-axis
unset logscale y
dataroot = './Results'.targetSystem

plot [1:30] \
    dataroot.'/3.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize 3.75' dashtype 1 lw 3 lc palette frac 0, \
    dataroot.'/2.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize 2.75' dashtype 1 lw 3 lc palette frac 0.2, \
    dataroot.'/1.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize 1.75' dashtype 1 lw 3 lc palette frac 0.4, \
    dataroot.'/-1.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 3 lw 3 lc palette frac 0.6, \
    dataroot.'/-2.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize -2.75' dashtype 3 lw 3 lc palette frac 0.8, \
    dataroot.'/-3.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 3 lw 3 lc palette frac 1.0
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
