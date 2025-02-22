set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

set ylabel '$\nabla \cdot \bm{I}$'offset char 5, char 0 
unset logscale y
#set yrange[-50:200]
dataroot = './Results'.targetSystem
set key title 'Direction' offset char -1, char 0.75

set ytics offset char -1.5, char 0  
set yrange [-1e-4:1e-4]
plot [1:30] \
    dataroot.'Starting_at/1.0472/meanline_Continuity_30x15NoBC.dat' using 1: ($2+$3) with lines title '\footnotesize $x+y$' dashtype 1 lw 4 lc palette frac 0.2,\
    dataroot.'Starting_at/1.0472/meanline_Continuity_30x15NoBC.dat' using 1:2 with lines title '\footnotesize $x$' dashtype 3 lw 4 lc'#E5DC8B',\
    dataroot.'Starting_at/1.0472/meanline_Continuity_30x15NOBC.dat' using 1:3 with lines title '\footnotesize $y$' dashtype 1 lw 4 lc palette frac 0.4,\

set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
