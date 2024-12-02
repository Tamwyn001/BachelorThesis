set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

unset logscale y
dataroot = './Results'.targetSystem

plot [1:30] \
    dataroot.'/mu_delta_-3.75_0.02/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 1 lw 3.5 lc palette frac 0.2,\
    dataroot.'/mu_delta_-2.75_0.036//meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize -2.75' dashtype 1 lw 3.5 lc palette frac 0.4, \
    dataroot.'/mu_delta_-1.75_0.14/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 1 lw 3.5 lc palette frac 0.6, \
    dataroot.'/mu_delta_1.75_0.116/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize 1.75' dashtype 3 lw 3.5 lc palette frac 0.8, \
    dataroot.'/mu_delta_2.75_0.05/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize 2.75' dashtype 3 lw 3.5 lc palette frac 1.0, \

    
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
