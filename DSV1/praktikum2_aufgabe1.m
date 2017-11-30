
clear all;
close all;
clc;

t = 0:1e-7:1e-3;
f0 = 3000;
x = cos(2 * pi * f0 * t).^2;

plot(t, x);


