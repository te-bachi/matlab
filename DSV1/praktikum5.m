
clear all;
close all;
clc;

x1 = [ 1  1  1  1 ];
x2 = [ 1  0 -1  0 ];
x3 = [ 0  1  0 -1 ];
x4 = [ 0 1 3 6 3 1 0 ];
x5 = [ 0 1 3 6 3 1 0 0];


f06 = 5;
fs6 = 0.01;
n6 = [0:fs6:1];
N6 = length(n6);
x6 = sin(f06*n6*2*pi);
figure;
plot(n6, x6);

%                   x   N
y1 = praktikum5_dft(x1, length(x1));
y2 = praktikum5_dft(x2, length(x2));
y3 = praktikum5_dft(x3, length(x3));
y4 = praktikum5_dft(x4, length(x4));
y5 = praktikum5_dft(x5, length(x5));
y6 = praktikum5_dft(x6, N6);
abs(y5);

%{
figure;
plot([0:1:length(x4)-1], abs(y4));

figure;
plot([0:1:length(x5)-1], abs(y5));
%}

figure;
s6 = abs(y6);
plot(n6(1:floor(N6/2)) / fs6, s6(1:floor(N6/2)));

