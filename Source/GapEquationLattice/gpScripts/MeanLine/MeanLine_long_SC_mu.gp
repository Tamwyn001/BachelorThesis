set loadpath './gpScripts/'
load '../config/palettes/Candy.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

unset logscale y
set ylabel '$\bm{\langle c_{i\uparrow}c_{i\downarrow}\rangle}$'
set yrange [-0.01:0.18]
dataroot = './Results'.targetSystem
set key title '$\mu$' offset char -3, char 0.75

# set palette rgbformulae 22,13,-31   # Secondary darker palette (automatically derived)

plot[1:40] dataroot.'/-3.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize -3.5' dashtype 1 lw 4 lc palette frac 0.0,\
     dataroot.'/-2.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize -2.5' dashtype 1 lw 4 lc palette frac 0.2, \
     dataroot.'/-1.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize -1.5' dashtype 1 lw 4 lc palette frac 0.6, \
     dataroot.'/-0.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize -0.5' dashtype 1 lw 4 lc palette frac 1.0, \
     dataroot.'/0.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize 0.5' dashtype 3 lw 4 lc "#1AA8EF", \
     dataroot.'/1.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize 1.5' dashtype 3 lw 4 lc "#D2C237", \
     dataroot.'/2.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize 2.5' dashtype 3 lw 4  lc "#A733EB", \
     dataroot.'/3.5/meanline_40x30NoBC.dat' using 1:2 with lines title '\footnotesize 3.5' dashtype 3 lw 4 lc "#2CDD73"

set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
