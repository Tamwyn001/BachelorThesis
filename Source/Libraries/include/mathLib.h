#ifndef MATHLIB_H
#define MATHLIB_H

double fermi_dirac(double E, double T);

class complex{
private:
    double re, im;

public:
    complex(double r = 0., double i = 0.){
        re = r;
        im = i;
    }

    static double real(complex& c);
    static double imag(complex& c);
    static double abs(complex& c);
    static complex conj(complex& c);

    complex operator+(complex& c){
        return complex(re + c.re, im + c.im);
    }

    complex operator-(complex& c){
        return complex(re - c.re, im - c.im);
    }
    complex operator*(complex& c){
        return complex(re * c.re - im*c.im, re*c.im + im * c.re);
    }

};
#endif