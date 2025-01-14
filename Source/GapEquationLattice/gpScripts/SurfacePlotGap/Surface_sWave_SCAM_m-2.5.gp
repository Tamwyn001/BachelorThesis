# set loadpath './gpScripts/'
# load './SystemDesc/SC20-all20.cfg'

set loadpath './config'

# targetSystem = 'Correlation_cdagg_c_/meanline20x20/'
# load config snippets
# load 'gnuplot.cfg'

set terminal epslatex size 6,2.62 color colortext

load 'gnutolatexBase.cfg'
load '../config/palettes/SandBeach.pal'
# Gnuplot script to plot a line from a data file
# set terminal pngcairo size 800,600
# set output 'plot.png'

# Set labels for the axes
set xlabel '{\small\textbf{$\bm{e}_x$}}' 
set ylabel '{\small\textbf{$\bm{e}_y$}}' 

set zlabel '$\bm{\langle c_{i\uparrow}c_{i\downarrow}\rangle}$' offset char 2,0 rotate parallel
set cbtics format "{\\tiny $ 10^\{%+3T\}$}" 
set ztics format "{\\tiny $ 10^\{%+3T\}$}" 
set ztics offset char  -1,0
set ylabel offset char 3, 0
set dgrid3d 30,30 qnorm 2  # Creates a grid from scattered data
set pm3d at b 	           # Fills the surface with color
set view 59.0, 352.0
set key outside            # Places the legend outside the plot
set ticslevel 0            # Sets the zero level for the Z-axis
set logscale z             # Apply logarithmic scale to Z-axis

set xrange[1:40.1]
set yrange[1:30.1]
set zrange[1.1e-5:1e0]
set palette maxcolors 30
set cblabel '$\langle c_{i\uparrow}c_{i\downarrow}\rangle$' norotate offset char -10,4
set logscale cb
set cbrange [2e-4:2e-2]
set cbtics offset char 1,0.015
set colorbox size 0.75

path = "./Results/SC20AM20_m0.5/NotFourier/TiltedInterface/FreeDelta/diffMU/"

splot path.targetSystem."/40x30NoBC.dat" u 1:2:3 w l lc palette lw 3 notitle
