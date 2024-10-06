lib := ../Libraries
bin := bin

all: $(bin)/mathLib.dll $(bin)/20x20lattice

# Ensure mathLib.dll is built before 20x20lattice and that there are some changes in the source files
$(bin)/20x20lattice: 20x20lattice.cpp 20x20lattice.h $(bin)/mathLib.dll
	g++ 20x20lattice.cpp -o $(bin)/20x20lattice -I. -I$(lib)/include -lmathLib -L$(bin)/

# Create shared library (mathLib.dll) if the source has been modified
$(bin)/mathLib.dll: $(lib)/src/mathLib.cpp $(lib)/include/mathLib.h
	g++ -fpic -shared $(lib)/src/mathLib.cpp -I$(lib)/include -o $(bin)/mathLib.dll

clean:
	rm -f $(bin)/20x20lattice
	rm -f $(bin)/mathLib.dll
