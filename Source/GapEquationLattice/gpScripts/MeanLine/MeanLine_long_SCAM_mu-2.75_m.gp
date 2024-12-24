set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC10-AM10.cfg'
load '/MeanLine/MeanLine_Base.gp'

set logscale y
dataroot = './Results'.targetSystem
sys = 'NotFourier/FreeDelta/diffMU/-2.75'
set yrange [1.0e-14:0.1]
set multiplot



plot [1:30] \
    dataroot.'/SC15AM15_m0/'.sys.'/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.0$' dashtype 1 lw 3.5 lc palette frac 0.2,\
    dataroot.'/SC15AM15_m0.25/'.sys.'/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.25$' dashtype 1 lw 3.5 lc palette frac 0.4,\
    dataroot.'/SC15AM15_m0.5/'.sys.'/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.5$' dashtype 1 lw 3.5 lc palette frac 0.6,\
    dataroot.'/SC15AM15_m0.75/'.sys.'/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize  $m=0.75$' dashtype 1 lw 3.5 lc palette frac 0.8,\
    dataroot.'/SC15AM15_m1/'.sys.'/meanline_30x20NoBC.dat' using 1:2 with lines title '\footnotesize  $m=1.0$' dashtype 1 lw 3.5 lc palette frac 1.0,\


set origin 0.25, 0.14
set size 0.6
set size ratio 1.5 #15/36
set yrange [5.0e-5:0.02]
set ytics format "{\\tiny \\(%.0te^{%+01T}\\)}"  offset char 0.75, 0.2
set xtics format "{\\tiny \\(%.0f\\)}"  offset char 0.0, 0.83
set mxtics 2
set xtics 5
set xtics format ""  # Major ticks at log intervals, hide their labels
set xtics add ("\\tiny \\(15\\)" 15, "\\tiny \\(30\\)" 30)  # Add labeled ticks at specific positions
set ytics 1e-6, 10, 1e-1 format ""  # Major ticks at log intervals, hide their labels
set ytics add ("\\tiny \\(1e-2\\)" 1.0e-2, "\\tiny \\(1e-4\\)" 1.0e-4)  # Add labeled ticks at specific positions
set mytics 5 
unset xlabel
unset ylabel
unset label
unset key
unset object 1
plot [14:30]\
    dataroot.'/SC15AM15_m0.5/'.sys.'/meanline_30x20NoBC.dat' using 1:2 with lines dashtype 1 lw 3.5 lc palette frac 0.6,\
    dataroot.'/SC15AM15_m0/'.sys.'/meanline_30x20NoBC.dat' using 1:2 with lines   dashtype 1 lw 3.5 lc palette frac 0.2




unset multiplot
set out
# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
