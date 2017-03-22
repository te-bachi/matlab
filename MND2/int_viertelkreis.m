
clear all;
close all;
clc;

f = @(x) sqrt(1 - x.^2);

% I = int_links(f, 0, 1, 10^-6);

h  = 10^-6;
n  = 1 / h;
x  = linspace(0, 1, n + 1);
IR = h * sum(f(x(2:end)));
IL = h * sum(f(x(1:end - 1)));
IT = h * 