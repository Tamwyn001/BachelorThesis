set loadpath './config'
# targetSystem = 'Correlation_cdagg_c_/meanline20x20/'
# load config snippets
# load 'gnuplot.cfg'
load 'gnutolatexBase.cfg'
load 'gnutolatex_ext3D.cfg'
load 'palettes/SandBeach.pal'

# Gnuplot script to plot a line from a data file
# set terminal pngcairo size 800,600
# set output 'plot.png'

# Set labels for the axes
set xlabel '{\small\textbf{Lattice site $i_x$ in $\bm{e}_x$}}' 
set ylabel '{\small\textbf{Lattice site $i_y$ in $\bm{e}_y$}}'

# Title for the plot
unset title # '\textbf{Correlation of the c operators}' 

set mxtics 2
set mytics 2
set key bottom left reverse Left

x0 = 10.5

set style line 1 lt 0 lw 2 lc rgb "black" # Dashed line style
set arrow from x0, graph 0 to x0, graph 1 nohead ls 1 #actual dashed line

materialY = 1.06
set label 'SC' at graph 0.25, materialY center
set label 'AM' at graph 0.75, materialY center

# Plot the data from the file 'data.txt' using columns 1 and 2
dataroot = './Results'.targetSystem

# Enable pm3d mode for heatmap
set pm3d map
set palette maxcolors 20
# Set square plot
set size square 1

# Set the range of x and y axes from 1 to 20
set xrange [1:20]
set yrange [1:20]

# pause -1
