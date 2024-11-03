set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'
set key outside right # Places the legend to the right of the plot area
set key at graph 1.7, 0 # Adjusts the legend position on the x-axis
set ylabel '$\bm{Re(\Delta)$}'

unset logscale y
dataroot = './Results'.targetSystem
file = '/meanline30x15NoBC_step_'
plot [1:30] \
dataroot.file.'1'.'.dat'  using 1:2 with lines title '\footnotesize 1' dashtype 1 lw 3 lc palette frac 0.0, \
dataroot.file.'2'.'.dat'  using 1:2 with lines title '\footnotesize 2' dashtype 3 lw 3 lc palette frac 0.2, \
dataroot.file.'3'.'.dat' using 1:2 with lines title '\footnotesize 3' dashtype 1 lw 3 lc palette frac 0.4, \
dataroot.file.'4'.'.dat'  using 1:2 with lines title '\footnotesize 4' dashtype 3 lw 3 lc palette frac 0.6, \
dataroot.file.'5'.'.dat' using 1:2 with lines title '\footnotesize 5' dashtype 1 lw 3 lc palette frac 0.8, \
# dataroot.file.'6'.'.dat' using 1:2 with lines title '\footnotesize 6' dashtype 3 lw 3 lc palette frac 0.25, \
# dataroot.file.'7'.'.dat' using 1:2 with lines title '\footnotesize 7' dashtype 1 lw 3 lc palette frac 0.3, \
# dataroot.file.'8'.'.dat' using 1:2 with lines title '\footnotesize 8' dashtype 3 lw 3 lc palette frac 0.35, \
# dataroot.file.'9'.'.dat' using 1:2 with lines title '\footnotesize 9' dashtype 1 lw 3 lc palette frac 0.4, \
# dataroot.file.'10'.'.dat' using 1:2 with lines title '\footnotesize 10' dashtype 3 lw 3 lc palette frac 0.45, \
# dataroot.file.'11'.'.dat' using 1:2 with lines title '\footnotesize 11' dashtype 1 lw 3 lc palette frac 0.5, \
# dataroot.file.'12'.'.dat' using 1:2 with lines title '\footnotesize 12' dashtype 3 lw 3 lc palette frac 0.55, \
# dataroot.file.'13'.'.dat' using 1:2 with lines title '\footnotesize 13' dashtype 1 lw 3 lc palette frac 0.6, \
# dataroot.file.'14'.'.dat' using 1:2 with lines title '\footnotesize 14' dashtype 3 lw 3 lc palette frac 0.65, \
# dataroot.file.'15'.'.dat' using 1:2 with lines title '\footnotesize 15' dashtype 1 lw 3 lc palette frac 0.7, \
# dataroot.file.'16'.'.dat' using 1:2 with lines title '\footnotesize 16' dashtype 3 lw 3 lc palette frac 0.75, \
# dataroot.file.'17'.'.dat' using 1:2 with lines title '\footnotesize 17' dashtype 1 lw 3 lc palette frac 0.8, \
# dataroot.file.'18'.'.dat' using 1:2 with lines title '\footnotesize 18' dashtype 3 lw 3 lc palette frac 0.85, \
# dataroot.file.'19'.'.dat' using 1:2 with lines title '\footnotesize 19' dashtype 1 lw 3 lc palette frac 0.9, \
# dataroot.file.'20'.'.dat' using 1:2 with lines title '\footnotesize 20' dashtype 3 lw 3 lc palette frac 1.0


set out

# TODO USE MUTLIPLE ANFANGSWERTMETHODEN (constant etc) TO GET A BETTER MEANLINE
