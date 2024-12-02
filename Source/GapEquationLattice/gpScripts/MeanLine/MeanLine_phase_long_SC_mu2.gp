set loadpath './gpScripts/'
load '../config/palettes/SandBeach.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

set ylabel '$\bm{\varphi}$' offset char 3, char 0 
unset logscale y
#set yrange[-50:200]
dataroot = './Results'.targetSystem
set yrange[30:180]
plot [1:30] \
    dataroot.'/-3.75/Starting_at/1.0472/meanline_Phase_30x15VertBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =-3.75$' dashtype 1 lw 3.5 lc palette frac 0.2,\
    dataroot.'/-2.75/Starting_at/1.0472/meanline_Phase_30x15VertBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =-2.75$' dashtype 1 lw 3.5 lc palette frac 0.4, \
    dataroot.'/-1.75/Starting_at/1.0472/meanline_Phase_30x15VertBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =-1.75$' dashtype 1 lw 3.5 lc palette frac 0.6,\
    dataroot.'/1.75/Starting_at/1.0472/meanline_Phase_30x15VertBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =1.75$' dashtype 3 lw 3.5 lc palette frac 0.8, \
    dataroot.'/2.75/Starting_at/1.0472/meanline_Phase_30x15VertBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =2.75$' dashtype 3 lw 3.5 lc palette frac 1.0
set out
