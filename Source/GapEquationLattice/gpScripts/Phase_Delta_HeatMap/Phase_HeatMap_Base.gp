set loadpath './config'

load 'gnutolatexBase.cfg'
load 'gnutolatex_ext3D.cfg'
load 'palettes/SandBeach.pal'


# Set labels for the axes
set xlabel '{\small\textbf{Lattice site $i_x$ in $\bm{e}_x$}}' 
set ylabel '{\small\textbf{Lattice site $i_y$ in $\bm{e}_y$}}'

# Title for the plot
unset title # '\textbf{Correlation of the c operators}' 
set key bottom left reverse Left


dataroot = './Results'.targetSystem

# Enable pm3d mode for heatmap
set pm3d map
set palette maxcolors 20
# Set square plot

set mxtics 2
set mytics 2

set cbrange [-180:180]
set cbtics format "{\\tiny %.0f°}" 
# pause -1
