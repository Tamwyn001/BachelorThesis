set loadpath './config'

# targetSystem = 'Correlation_cdagg_c_/meanline20x20/'
# load config snippets
# load 'gnuplot.cfg'

load 'gnutolatexBase.cfg'
load 'gnutolatex_ext2D.cfg'

# Gnuplot script to plot a line from a data file
# set terminal pngcairo size 800,600
# set output 'plot.png'

# Set labels for the axes
set xlabel '{\small\textbf{Lattice site $i$ in $\bm{e}_x$}}' 
set ylabel '$\bm{|\langle c_{i\uparrow}c_{i\downarrow}\rangle|$}'

# Title for the plot
unset title # '\textbf{Correlation of the c operators}' 
set logscale y
set ytics offset char -1, char 0  

set mxtics 2
set key bottom left reverse Left

# pause -1
