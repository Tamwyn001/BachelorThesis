set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC10-AM10.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results/SC20AM20_m0.5/DWave/TiltedInterface/FreeDelta/diffMU/'

set key offset char 0.0, char -2
# set yrange [1.0e-14:0.1]
# set multiplot
set pm3d at s

plot [1:40] \
    dataroot.'-2.5/40x30NoBC_F_D10.dat' title '\footnotesize -2.5'


# set origin 0.48, 0.325
# set size 0.6
# set size ratio 1 #15/36
# set yrange [2.0e-5:0.005]

# set xtics format "{\\tiny \\(%.0f\\)}"  offset char 0.0, 0.3
# set mxtics 2
# set xtics 5
# set xtics format ""  # Major ticks at log intervals, hide their labels
# set xtics add ("\\tiny \\(15\\)" 15, "\\tiny \\(30\\)" 30)  # Add labeled ticks at specific positions
# set logscale y
# set ytics 1e-6, 10, 1e-1 format "" offset char 16,0 # Major ticks at log intervals, hide their labels
# set ytics add ("\\tiny \\(10^{-3}\\)" 1.0e-3, "\\tiny \\(10^{-4}\\)" 1.0e-4)  # Add labeled ticks at specific positions
# set mytics 5 
# unset xlabel
# unset ylabel
# unset label
# unset key
# unset object 1
# plot [14:30]\
#     dataroot.'/SC15AM15_m0.75/'.sys.'/meanline_40x30NoBC.dat' using 1:2 with lines dashtype 1 lw 3.5 lc palette frac 0.8,\
#     dataroot.'/SC15AM15_m0/'.sys.'/meanline_40x30NoBC.dat' using 1:2 with lines   dashtype 1 lw 3.5 lc palette frac 0.2




# unset multiplot
set out
# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
