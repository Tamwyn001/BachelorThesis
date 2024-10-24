set loadpath './config'

# targetSystem = 'Correlation_cdagg_c_/meanline30x30/'
# load config snippets
# load 'gnuplot.cfg'

load 'gnutolatexBase.cfg'
load 'gnutolatex_ext2D.cfg'

# Gnuplot script to plot a line from a data file
# set terminal pngcairo size 800,600
# set output 'plot.png'

# Set labels for the axes
set xlabel '{\small\textbf{Lattice site $i$ in $\bm{e}_x$}}' 
set ylabel '$|\bm{\langle c_{i\uparrow}c_{i\downarrow}\rangle|$}'

# Title for the plot
unset title # '\textbf{Correlation of the c operators}' 
set ytics offset char -1, char 0  
set logscale y
set mxtics 2
set key bottom left reverse Left

x0 = 10.5

set style line 1 lt 0 lw 2 lc rgb "black" # Dashed line style
#set arrow from x0, graph 0 to x0, graph 1 nohead ls 1 #actual dashed line


materialY = 1.06
set label 'SC' at graph 0.5, materialY

# Plot the data from the file 'data.txt' using columns 1 and 2
dataroot = './Results'.targetSystem
plot [1: 30] dataroot.'/meanline_30x15NoBC.dat' using 1:2 with lines title '\footnotesize No PBC' lw 5 linecolor rgb "#666A86",\
 dataroot.'/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize Vert PBC' lw 5 linecolor rgb "#92B6B1"
set out
# pause -1
