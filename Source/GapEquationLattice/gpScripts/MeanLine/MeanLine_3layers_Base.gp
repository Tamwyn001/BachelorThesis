set loadpath './config'
load '/MeanLine/MeanLine_Base.gp'


# Plot the data from the file 'data.txt' using columns 1 and 2
dataroot = './Results'.targetSystem
plot [1: 31] dataroot.'/meanline_31x15NoBC.dat' using 1:2 with lines title '\footnotesize No PBC' lw 5 linecolor rgb "#666A86",\
 dataroot.'/meanline_31x15VertBC.dat' using 1:2 with lines title '\footnotesize Vert PBC' lw 5 linecolor rgb "#92B6B1"
set out
# pause -1
