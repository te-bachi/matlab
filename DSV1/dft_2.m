
clear all;
close all;
clc;

f0   = 0.25;
fs   = 2;
T    = 4;
N    = T * fs + 1;
n    = [0:1:N-1];
t    = [0:fs/T:T];
Ts   = 1/fs;
Tdft = fs * N;
x    = sin(f0 * 2 * pi * n / fs);

fprintf('len(n) = %d\n', length(n));
fprintf('len(t) = %d\n', length(t));
fprintf('len(x) = %d\n', length(x));

%--------------------------------------------------------------------------
%                   x   N
y = praktikum5_dft(x, N);

%--------------------------------------------------------------------------
figure;
subplot(2,1,1);
title('Zeitbereich');
scatter(t, x);
grid on;
grid minor;
xlabel('Zeit t [s]');

subplot(2,1,2);
scatter(n, x);
grid on;
grid minor;
xlabel('Abtastwerte n [#]');

%--------------------------------------------------------------------------
figure;
s = abs(y);
%plot(n(1:floor(N/2)) / fs, s(1:floor(N/2)));
scatter(n, s);
