set loadpath './gpScripts/'
load '../config/palettes/Candy.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'


# set multiplot
set logscale y
set ylabel '$\bm{|F_d|}$' 
set key title '$\mu$' offset char -3, char 0.75

# unset xlabel
# set size noratio
# set origin -0.2, 0.4
# set size 1.205, 0.65
# set key offset 0, char -4
# set xtics format ""

dataroot = './Results'.targetSystem
plot [1:40] \
    dataroot.'/-3.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize -3.5' dashtype 1 lw 4 lc palette frac 0.0,\
    dataroot.'/-2.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize -2.5' dashtype 1 lw 4 lc palette frac 0.2, \
    dataroot.'/-1.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize -1.5' dashtype 1 lw 4 lc palette frac 0.6, \
    dataroot.'/-0.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize -0.5' dashtype 1 lw 4 lc palette frac 1.0, \
    dataroot.'/0.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize 0.5' dashtype 3 lw 4 lc "#1AA8EF", \
    dataroot.'/1.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize 1.5' dashtype 3 lw 4 lc "#D2C237", \
    dataroot.'/2.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize 2.5' dashtype 3 lw 4  lc "#A733EB", \
    dataroot.'/3.5/meanline_40x30NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize 3.5' dashtype 3 lw 4 lc "#2CDD73"
#set yrange [-0.1:0.25]
# plot [1:30] \
#     dataroot.'/-3.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize -3.75' dashtype 1 lw 4 lc palette frac 0.0,\
#     0 title '\footnotesize -2.75' dashtype 1 lw 4 lc palette frac 0.2, \
#     dataroot.'/-1.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize -1.75' dashtype 1 lw 4 lc palette frac 0.6, \
#     dataroot.'/-0.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize -0.75' dashtype 1 lw 4 lc palette frac 1.0, \
#     dataroot.'/0.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize 0.75' dashtype 3 lw 4 lc "#1AA8EF", \
#     0 title '\footnotesize 1.75' dashtype 3 lw 4 lc "#D2C237", \
#     dataroot.'/2.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize 2.75' dashtype 3 lw 4  lc "#A733EB",\
#     dataroot.'/3.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines title '\footnotesize 3.75' dashtype 3 lw 4 lc "#2CDD73"
    

# set size noratio
# set size 0.785, 0.35
# set origin 0.0145, 0.075
# set xtics format "{ \\(%.0f\\)}" # offset char 0.0, 0.5
# unset ylabel
# unset key
# unset label 3
# unset label 4
# unset label 5
# set xlabel '{\small\textbf{Lattice site $i$ in $\bm{e}_x$}}'  offset char 0.0, 0.65


# plot [1:30] \
#     dataroot.'/-2.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines notitle dashtype 1 lw 4 lc palette frac 0.2, \
#     dataroot.'/1.75/meanline_30x15NoBC_F_D10.dat' using 1:2 with lines notitle dashtype 3 lw 4  lc "#D2C237"


# unset multiplot 
set out