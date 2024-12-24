set loadpath './gpScripts/'
load '../config/palettes/Candy.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

set ylabel '$\nabla \cdot \bm{I}$'offset char 6, char 0 
unset logscale y
#set yrange[-50:200]
dataroot = './Results'.targetSystem
set yrange [-5e-6:5e-6]
plot [1:30] \
    dataroot.'/Starting_at/1.0472/meanline_Continuity_30x15NoBC.dat' using 1:2 with lines title '\footnotesize $x$' dashtype 1 lw 3.5 lc palette frac 0.2,\
    dataroot.'/Starting_at/1.0472/meanline_Continuity_30x15NOBC.dat' using 1:3 with lines title '\footnotesize $y$' dashtype 1 lw 3.5 lc palette frac 0.5,\
    dataroot.'/Starting_at/1.0472/meanline_Continuity_30x15NoBC.dat' using 1: ($2+$3) with lines title '\footnotesize $x+y$' dashtype 3.5 lw 3.5 lc palette frac 1,\
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
