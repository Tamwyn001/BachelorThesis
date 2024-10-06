#include "20x20lattice.h"
#include <iostream>
#include "../Libraries/include/mathLib.h"
using namespace std;

int main()
{

    double E = 1.0;
    double T = 0.1;

    std::cout << "System distribution "<< fermi_dirac(E, T) << std::endl;
    return 0;
}