clc, clear all, clf;
x=[24 26 30 35 38 39 39 37 35 31 42 47];
y=[37 33 29 29 34 38 41 43 46 48 47 44];
A=[x.^2;2*x.*y;y.^2;2*x;2*y];
b=[x;y];
b = b';
A = A'*A;
QR_Solver(A,b)