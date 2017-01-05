
clc;
clear;

f = @(x) 1 * sin(2*pi*x));
x = linspace(0,2*pi);
y = f(x);

plot(x, y);
hold on;
grid on;
