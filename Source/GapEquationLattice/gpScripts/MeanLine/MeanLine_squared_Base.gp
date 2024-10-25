set loadpath './gpScripts/'
load '/MeanLine/MeanLine_Base.gp'


# Plot the data from the file 'data.txt' using columns 1 and 2
dataroot = './Results'.targetSystem
plot [1: 20] dataroot.'/meanline_20x20NoBC.dat' using 1:2 with lines title '\footnotesize No PBC' lw 5 linecolor rgb "#666A86",\
 dataroot.'/meanline_20x20VertBC.dat' using 1:2 with lines title '\footnotesize Vert PBC' lw 5 linecolor rgb "#92B6B1",\
 dataroot.'/meanline_20x20VertHorizBC.dat' using 1:2 with lines title '\footnotesize Vert \& horiz PBC' lw 5 linecolor rgb "#E8DDB5"
set out
# pause -1
