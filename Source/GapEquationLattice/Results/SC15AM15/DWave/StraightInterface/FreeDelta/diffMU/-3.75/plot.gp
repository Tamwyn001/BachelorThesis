
set ylabel '%' tc lt 1


# set logscale y2
plot [1:30]'meanline_30x15NoBC_F_D10.dat' using 1:2 with line linetype 1 lw 2.5