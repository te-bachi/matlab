
clear all;
close all;
clc;

f0   = 0.25;
fs   = 2;
N    = 8;
T    = 4;
n    = [0:fs:fs*N-1];
Ts   = 1/fs;
Tdft = fs * N;
x    = sin(f0 * 2 * pi * n / fs);


%--------------------------------------------------------------------------
%                   x   N
y = praktikum5_dft(x, N);

%--------------------------------------------------------------------------
figure;
scatter(n, x);
grid on;
grid minor;

%--------------------------------------------------------------------------
figure;
s = abs(y);
%plot(n(1:floor(N/2)) / fs, s(1:floor(N/2)));
scatter(n / fs, s);

