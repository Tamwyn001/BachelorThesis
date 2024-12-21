set loadpath './gpScripts/'
load '../config/palettes/Candy.pal'
load '/SystemDesc/SC.cfg'
load '/MeanLine/MeanLine_Base.gp'

set ylabel '$\bm{\varphi}$' offset char 3, char 0 
unset logscale y
#set yrange[-50:200]
dataroot = './Results'.targetSystem
set yrange[40:180]
plot [1:30] \
    dataroot.'/-3.75/Starting_at/1.0472/meanline_Phase_30x15NoBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =-3.75$' dashtype 1 lw 4 lc palette frac 0.0,\
    dataroot.'/-2.75/Starting_at/1.0472/meanline_Phase_30x15NoBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =-2.75$' dashtype 1 lw 4 lc palette frac 0.2, \
    dataroot.'/-1.75/Starting_at/1.0472/meanline_Phase_30x15NoBC.dat' using 1:($2*180/pi) with lines title '\footnotesize $\mu =-1.75$' dashtype 1 lw 4 lc palette frac 0.6
set out
