//
//  main.c
//  NonlinScalarEquations
//
//  Created by Simon Iwan Stingelin on 27/10/15.
//  Copyright © 2015 ZHAW. All rights reserved.
//

#include <stdio.h>
#include <math.h>

double f(double x)
{
    return << SNIPP >>;
}

double df(double x)
{
    return << SNIPP >>;
}


double g(double x)
{
    return << SNIPP >>;
}

void bisection(double (*f)(double) ,double a, double b, double tol)
{
    printf("n   a           b           b-a\n");

    // f(a) < 0 && f(b) > 0 otherwise use -f(x)
    double sign=1.0;


    << SNIPP >>
    
    
    int n=0;
    while ((b-a)>tol){
        n++;
        
        << SNIPP >>
        
        printf("%3d %10.8f\t%10.8f\t%10.8f\n",n,a,b,b-a);
    }
    return;
}

void fixpoint(double (*f)(double) ,double x0, double tol)
{
    double xn=f(x0);
    printf("n    xn         f(xn)       xn-f(xn)\n");
    printf("%3d %10.8f\t%10.8f\t%10.8f\n",0,x0,xn,x0-xn);
    int n=0;
    while(fabs(f(xn)-xn)>tol){
        n++;

        << SNIPP >>
        
        printf("%3d\t%10.8f\t%10.8f\t%10.8f\n",n,x0,xn,x0-xn);
    }

    return;
}

void newton(double (*f)(double), double (*df)(double),
            double x0, double tol)
{
    double xn,xm;
    xm = x0;
    printf("n    x(n)         f(x(n))       x(n)-x(n-1)\n");
    int n=0;
    do{
        n++;
        
        << SNIPP >>
        
        printf("%3d\t%12.8f %13.6g  %13.6g\n",n,xn,f(xn),xn-xm);
    }while(fabs(xn-xm)>tol);
    
    return;
}


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Berechnen einer Lösung von cos(x) -x = 0\n");
    
    printf("1) Mit Hilfe des Intervallhalbierungsverfahren\n");
    
    bisection(&f , 0., 1., 1e-5);
    
    printf("\n2) Mit Hilfe der Fixpunkt-Iteration\n");
    
    fixpoint(&g , .2, 1e-5);
    
    printf("\n3) Mit Hilfe des Newton-Verfahren\n");
    
    newton(&f, &df , .2, 1e-5);
    
    return 0;
}
