set loadpath './config'
load 'gnutolatexBase.cfg'
load 'palettes/SandBeach.pal'
load 'latticeConfig.cfg'
load 'gnutolatex_ext2D.cfg'
set ylabel at graph 0, first 0 center offset char 3, char 0 

dataroot = './Results'.targetSystem
contrast = 0.5
scale = 2


enorm(x,y) = sqrt(x**2 + y**2)

dx(x,y) = x / enorm(x,y)
dy(x,y) = y / enorm(x,y)

logarrow(v1,v2) = log(1 + enorm(v1,v2))**contrast * scale


set mxtics 5
len = 4
set palette maxcolors 20