set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'
set key outside right # Places the legend to the right of the plot area
set key at graph 1.6, 0 # Adjusts the legend position on the x-axis

set ylabel '$\bm{\varphi}$'
unset logscale y

dataroot = './Results'.targetSystem
plot [1:30] \
    dataroot.'/0.5236/meanline_Phase_30x15NoBC.dat' using 1:2 with lines title '\footnotesize $\pi/6$' dashtype 3 lw 3 lc palette frac 0.3, \
    dataroot.'/1.0472/meanline_Phase_30x15NoBC.dat' using 1:2 with lines title '\footnotesize $\pi/3$' dashtype 3 lw 3 lc palette frac 0.5, \
    dataroot.'/-1.0472/meanline_Phase_30x15NoBC.dat' using 1:2 with lines title '\footnotesize $-\pi/3$' dashtype 3 lw 3 lc palette frac 0.8 

set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
