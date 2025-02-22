set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC12-AM12-SC12.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
#set yrange [-0.1:0.25]
plot [1:36] \
    dataroot.'/-3.75/meanline_36x15VertBC.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 1 lw 3.5 lc palette frac 0.0, \
    dataroot.'/-2.75/meanline_36x15VertBC.dat' using 1:2 with lines title '\footnotesize -2.75' dashtype 1 lw 3.5 lc palette frac 0.4, \
    dataroot.'/-1.75/meanline_36x15VertBC.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 1 lw 3.5 lc palette frac 0.6, \
    dataroot.'/1.75/meanline_36x15VertBC.dat' using 1:2 with lines title '\footnotesize 1.75' dashtype 3 lw 3.5 lc palette frac 0.8, \

    # dataroot.'/-3.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 1 lw 3.5 lc palette frac 0.2,\
    
    # dataroot.'/-2.2/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize -2.2' dashtype 1 lw 3.5 lc palette frac 0.6, \
    # dataroot.'/1.5/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize 1.5' dashtype 3 lw 3.5 lc palette frac 0.8, \
    
    
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
