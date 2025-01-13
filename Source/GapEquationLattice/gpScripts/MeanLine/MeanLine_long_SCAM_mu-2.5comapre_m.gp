set loadpath './gpScripts/'
load '../config/palettes/Candy.pal'
load '/SystemDesc/SC10-AM10.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
sys = 'NotFourierNEW/FreeDelta/diffMU/-2.5'
set yrange [1.0e-6:0.4]
plot [1:40] \
    dataroot.'/SC20AM20_m0/'.sys.'/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.0$' dashtype 1 lw 3.5 lc palette frac 0.0,\
    dataroot.'/SC20AM20_m0.25/'.sys.'/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.25$' dashtype 1 lw 3.5 lc palette frac 0.2,\
    dataroot.'/SC20AM20_m0.5/'.sys.'/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.5$' dashtype 1 lw 3.5 lc palette frac 0.4,\
    dataroot.'/SC20AM20_m0.75/'.sys.'/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.75$' dashtype 1 lw 3.5 lc palette frac 0.6,\
    dataroot.'/SC20AM20_m1/'.sys.'/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize  $m=1.0$' dashtype 1 lw 3.5 lc palette frac 0.8,\

    
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
