set ytics 10 nomirror tc lt 1
set ylabel '%' tc lt 1
set y2tics 0.1 nomirror tc lt 2
set y2range [0:1]
set y2label 'Mean ciup cidown' tc lt 2
plot [0:200]'trace.dat' using 1:2 with line linetype 1 lw 2.5  title 'Relative change', 'trace.dat'  using 1:($3/450) with line linetype 2 lw 2.5 axis x1y2 title 'Mean ciup cidown'