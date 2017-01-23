
clc;
clear;

f       = @(x) sin(x);
x       = [ -pi/2, -pi/4, 0, pi/4, pi/2 ];
h       = pi/4;
fi      = f(x);
b       = 6/h^2 * (fi(1:end-2) - 2*fi(2:end-1) + fi(3:end));

