set loadpath './gpScripts/'
load '../config/palettes/Candy.pal'
load '/SystemDesc/SC15-FM15.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
sys = '/SC15FM15/NotFourier/FreeDelta/diffMU/'
# set yrange [1.0e-8:1]



plot [1:30] \
    dataroot.sys.'-0.75/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize   $\mu=-0.75$' dashtype 1 lw 3.5 lc palette frac 0.0,\
    dataroot.sys.'-1.75./meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize  $\mu=-1.75$' dashtype 1 lw 3.5 lc palette frac 0.2,\
    dataroot.sys.'-2.75./meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize  $\mu=-2.75$' dashtype 1 lw 3.5 lc palette frac 0.4,\
    dataroot.sys.'-3.75./meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize  $\mu=-3.75$' dashtype 1 lw 3.5 lc palette frac 0.6,\

set out
# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
