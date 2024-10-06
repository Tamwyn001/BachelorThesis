#include "../include/mathlib.h"
#include <math.h>

double fermi_dirac(double E, double T) {
    return 1.0 / (exp((E) / (T)) + 1.0);
}

double complex::real(complex& c){
    return c.re;
}
double complex::imag(complex& c){
    return c.im;
}
double complex::abs(complex& c){
    return sqrt(c.re*c.re + c.im*c.im);
}
complex complex::conj(complex& c){
    return complex(c.re, (-1) * c.im);
}



