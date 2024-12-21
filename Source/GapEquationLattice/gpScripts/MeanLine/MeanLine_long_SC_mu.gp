set loadpath './gpScripts/'
load '../config/palettes/Candy.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

unset logscale y
set yrange [-0.01:0.18]
dataroot = './Results'.targetSystem

plot [1:30] \
    dataroot.'/-3.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 1 lw 4 lc palette frac 0.0,\
    dataroot.'/-2.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize -2.75' dashtype 1 lw 4 lc palette frac 0.2, \
    dataroot.'/-1.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 1 lw 4 lc palette frac 0.6, \
    dataroot.'/-0.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize -0.75' dashtype 1 lw 4 lc palette frac 1.0, \
    dataroot.'/0.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize 0.75' dashtype 3 lw 4 lc "#1AA8EF", \
    dataroot.'/1.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize 1.75' dashtype 3 lw 4 lc "#D2C237", \
    dataroot.'/2.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize 2.75' dashtype 3 lw 4  lc "#A733EB", \
    dataroot.'/3.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize 3.75' dashtype 3 lw 4 lc "#2CDD73",\
    
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
