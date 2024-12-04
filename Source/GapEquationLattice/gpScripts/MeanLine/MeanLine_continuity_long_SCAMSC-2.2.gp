set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC12-AM6-SC12.cfg'
load '/MeanLine/MeanLine_Base.gp'

set ylabel '$\nabla \cdot \bm{I}$' offset char 6, char 0 
unset logscale y

dataroot = './Results'.targetSystem
# set yrange [-6e-7:6e-7]
plot [1:30] \
    dataroot.'/Starting_at/1.0472/meanline_Continuity_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\mu =-2.2$' dashtype 3 lw 3.5 lc palette frac 0.6,\

set out


# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
