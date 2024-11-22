set loadpath './gpScripts/'
load '/MeanLine/MeanLine_Base.gp'


# Plot the data from the file 'data.txt' using columns 1 and 2
dataroot = './Results'.targetSystem
plot [1: 30]\
    dataroot.'/meanline_30x15VertBC.dat' using 1:2 with lines title '\footnotesize $\mu =-2.75$' dashtype 1 lw 3 lc palette frac 0.2

set out
# pause -1
