set loadpath './config'

load 'gnutolatexBase.cfg'
load 'gnutolatex_ext3D.cfg'
load 'palettes/SandBeach.pal'


# Set labels for the axes
set xlabel '{\small\textbf{Lattice site $i_x$ in $\bm{e}_x$}}' 
set ylabel '{\small\textbf{Lattice site $i_y$ in $\bm{e}_y$}}'


dataroot = './Results'.targetSystem


# set ylabel at graph 0, first 0 center offset char 3, char 0 
# set ytics offset char 0, char 0 

contrast = 1.0
scale = 1.4*1000.0
len = 4.0

enorm(x,y) = sqrt(x**2 + y**2)

dx(x,y) = x / enorm(x,y)
dy(x,y) = y / enorm(x,y)

logarrow(v1,v2) = log(1 + enorm(v1,v2))**contrast * scale


set mxtics 5
set mytics 2
set palette maxcolors 20

unset title # '\textbf{Correlation of the c operators}' 
set key outside right
set xtics offset char 0, char 0.4
set ytics offset char -1, char 0  
set ylabel offset char 3, char 0 

unset label 1
unset label 2
unset arrow 1
set xrange [0:31]
set yrange [0:16]
set size ratio 0.5 #30/15 ratio
set colorbox vertical user origin graph 1.025, 0.0 size 0.035, 0.8
set cbtics offset char 2, char 0
