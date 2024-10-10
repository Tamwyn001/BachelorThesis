set loadpath './config'

# targetSystem = 'Correlation_cdagg_c_/meanline20x20/'
# load config snippets
# load 'gnuplot.cfg'

load 'palette.cfg'
load 'gnutolatex.cfg'

# Gnuplot script to plot a line from a data file
# set terminal pngcairo size 800,600
# set output 'plot.png'

# Set labels for the axes
set xlabel '{\small\textbf{Lattice site $i$ in $\bm{e}_x$}}' 
set ylabel '$\bm{\langle c_{i\uparrow}c_{i\downarrow}\rangle$}'

# Title for the plot
unset title # '\textbf{Correlation of the c operators}' 
set logscale y

set mxtics 2
set key bottom left reverse Left

x0 = 10.5

set style line 1 lt 0 lw 2 lc rgb "black" # Dashed line style
set arrow from x0, graph 0 to x0, graph 1 nohead ls 1 #actual dashed line

materialY = 1.06
set label 'SC' at graph 0.25, materialY
set label 'AM' at graph 0.75, materialY

# Plot the data from the file 'data.txt' using columns 1 and 2
dataroot = './Results'.targetSystem
plot [1: 20] dataroot.'/meanline_20x20NoBC.dat' using 1:2 with lines title '\footnotesize No BC' lw 8 linecolor rgb "#78C3FB",\
 dataroot.'/meanline_20x20VertBC.dat' using 1:2 with lines title '\footnotesize Vert BC' lw 8 linecolor rgb "#A1E5AB",\
 dataroot.'/meanline_20x20VertHorizBC.dat' using 1:2 with lines title '\footnotesize Vert \& horiz BC' lw 8 linecolor rgb "#545E75"
set out
# pause -1
