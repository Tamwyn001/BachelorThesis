set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC12-AM6-SC12.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
#set yrange [-0.1:0.25]
plot [1:30] \
    dataroot.'/PhaseSide-3.1416/diffMU/-1.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\varphi=-\pi$' dashtype 3 lw 3.5 lc palette frac 0.0,\
    dataroot.'/PhaseSide-2.0944/diffMU/-1.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\varphi=-2\pi/3$' dashtype 3 lw 3.3 lc palette frac 0.2,\
    dataroot.'/PhaseSide-1.0472/diffMU/-1.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\varphi=-\pi/3$' dashtype 3 lw 3.2 lc palette frac 0.4,\
    dataroot.'/PhaseSide1.0472/diffMU/-1.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\varphi=\pi/3$' dashtype 3 lw 2.9 lc palette frac 0.6,\
    dataroot.'/PhaseSide-2.0944/diffMU/-1.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\varphi=2\pi/3$' dashtype 3 lw 2.7 lc palette frac 0.8,\
    dataroot.'/PhaseSide3.1416/diffMU/-1.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\varphi=\pi$' dashtype 3 lw 2.5 lc palette frac 1.0

set out

    # dataroot.'/PhaseSide2.0944/diffMU/-1.75/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\varphi=2\pi/3$' dashtype 3 lw 2.7 lc palette frac 0.8,\

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
