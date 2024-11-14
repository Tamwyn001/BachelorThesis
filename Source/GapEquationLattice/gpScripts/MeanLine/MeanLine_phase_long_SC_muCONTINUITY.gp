set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'
set key outside right # Places the legend to the right of the plot area
set key at graph 1.6, 0 # Adjusts the legend position on the x-axis

set ylabel '$\nabla \cdot \bm{I}$'
unset logscale y
#set yrange[-50:200]
dataroot = './Results'.targetSystem
set yrange [-2e-4:2e-4]
plot [1:30] \
    dataroot.'/0.75/LinearPhaseGradient/1.0472/meanline_Continuity_30x15NoBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu = 0.75$' dashtype 3 lw 3 lc palette frac 0.5
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
