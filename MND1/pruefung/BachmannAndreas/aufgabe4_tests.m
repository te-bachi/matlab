
clear all;
close all;
clc;

f_xy    = @(x, y)   (x-1)^2+8*(y-1/2)^2;
f_y     = @(x)      (2^(1/2)*(- x^2 + 2*x + 2)^(1/2))/4 + 1/2;

x = 5;
y = f_y(x);

