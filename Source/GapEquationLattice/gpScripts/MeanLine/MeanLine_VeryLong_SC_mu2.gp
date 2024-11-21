set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'
set key outside right # Places the legend to the right of the plot area
set key at graph 1.6, 0 # Adjusts the legend position on the x-axis
unset logscale y
dataroot = './Results'.targetSystem

plot [1:45] \
    dataroot.'/mu_delta_3.75_0.0072/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize 3.75' dashtype 1 lw 3 lc palette frac 0, \
    dataroot.'/mu_delta_2.75_0.056/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize 2.75' dashtype 1 lw 3 lc palette frac 0.2, \
    dataroot.'/mu_delta_1.75_0.129/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize 1.75' dashtype 1 lw 3 lc palette frac 0.4, \
    dataroot.'/mu_delta_-1.75_0.136/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 3 lw 3 lc palette frac 0.6, \
    dataroot.'/mu_delta_-2.75_0.056/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize -2.75' dashtype 3 lw 3 lc palette frac 0.8, \
    dataroot.'/mu_delta_-3.75_0.0072/meanline_45x15NoBC.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 3 lw 3 lc palette frac 1.0
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
