set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
set ylabel '$|F_d|$'
dataroot = './Results'.targetSystem

plot [1:30] \
    dataroot.'/-3.75/30x15VertBC_F_D.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 1 lw 3.5 lc palette frac 0.0,\
    dataroot.'/-2.75/30x15VertBC_F_D.dat' using 1:2 with lines title '\footnotesize -2.75' dashtype 1 lw 3.5 lc palette frac 0.2, \
    dataroot.'/-1.75/30x15VertBC_F_D.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 1 lw 3.5 lc palette frac 0.4, \
    dataroot.'/1.75/30x15VertBC_F_D.dat' using 1:2 with lines title '\footnotesize 1.75' dashtype 3 lw 3.5 lc palette frac 0.6, \
    dataroot.'/2.75/30x15VertBC_F_D.dat' using 1:2 with lines title '\footnotesize 2.75' dashtype 3 lw 3.5 lc palette frac 0.8, \
    dataroot.'/3.75/30x15VertBC_F_D.dat' using 1:2 with lines title '\footnotesize 3.75' dashtype 3 lw 3.5 lc palette frac 1.0,\
    
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
