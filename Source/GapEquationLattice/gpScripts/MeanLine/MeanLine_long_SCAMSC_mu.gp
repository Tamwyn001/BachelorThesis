set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC12-AM6-SC12.cfg'
load '/MeanLine/MeanLine_Base.gp'
set multiplot


set logscale y

unset xlabel
set ylabel offset char 2, char -3
set size noratio
set origin -0.2, 0.4
set size 1.205, 0.65
set key offset 0, char -4
set xtics format ""

dataroot = './Results'.targetSystem
#set yrange [-0.1:0.25]
plot [1:30] \
    0 title '\footnotesize -3.75' dashtype 1 lw 3.5 lc palette frac 0.0,\
    0 title '\footnotesize -2.75' dashtype 1 lw 3.5 lc palette frac 0.48,\
    dataroot.'/-1.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 1 lw 3.5 lc palette frac 0.8, \
    dataroot.'/-0.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize -0.75' dashtype 1 lw 3.5 lc palette frac 1, \
    dataroot.'/0.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize 0.75' dashtype 3 lw 3.5 lc "#BDB493", \
    dataroot.'/1.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize 1.75' dashtype 3 lw 3.5 lc "#739E67",\
    0 title '\footnotesize 2.75' dashtype 3 lw 3.5 lc palette frac "#5B6D86", \
    0 title '\footnotesize 3.75' dashtype 3 lw 3.5 lc "#333542"
    

set size noratio
set size 0.8, 0.35
set origin 0, 0.075
set xtics format "{ \\(%.0f\\)}" # offset char 0.0, 0.5
unset ylabel
unset key
unset label 3
unset label 4
unset label 5
set xlabel '{\small\textbf{Lattice site $i$ in $\bm{e}_x$}}'  offset char 0.0, 0.65


plot [1:30] \
    dataroot.'/-3.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 1 lw 3.5 lc palette frac 0.0,\
    dataroot.'/-2.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize -2.75' dashtype 1 lw 3.5 lc palette frac 0.48, \
    dataroot.'/2.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize 2.75' dashtype 3 lw 3.5 lc palette frac "#5B6D86", \
    dataroot.'/3.75/Starting_at/1.0472/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize 3.75' dashtype 3 lw 3.5 lc "#333542", \


unset multiplot 
set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
