
clear all;
close all;
clc;

%--------------------------------------------------------------------------
% a)
% Gegeben: fs + T
% Rechnet: T
f0   = 2;
fs   = 32;
T    = 0.5;
N    = T * fs + 1;

%--------------------------------------------------------------------------
% b)
% Gegeben: fs + N
% Rechnet: T
f0   = 0.25;
fs   = 2;
N    = 33;
T    = (N-1)/fs;

%--------------------------------------------------------------------------
% c)
% Gegeben: T + N
% Rechnet: fs
% f0   = 0.25;
% T    = 4;
% N    = 32;
% fs   = (N-1)/T;



%--------------------------------------------------------------------------
n    = [0:1:N-1];
t    = [0:1/fs:T];
Ts   = 1/fs;
Tdft = fs * N;
x    = sin(2 * pi * f0 * n / fs);

fprintf('len(n) = %d\n', length(n));
fprintf('len(t) = %d\n', length(t));
fprintf('len(x) = %d\n', length(x));
fprintf('T      = %1.4f\n', T);
fprintf('N      = %d\n', N);
fprintf('fs     = %d\n', fs);

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
xlim([0 T]);

subplot(2,1,2);
scatter(n, x);
grid on;
grid minor;
xlabel('Abtastwerte n [#]');
xlim([0 N-1]);
%xticks([0:fs:N]);
%ax = gca;
%ax.XTick = [0:1:N-1];

%--------------------------------------------------------------------------
figure;
s = abs(y);
scatter(n*fs/N, s);
grid on;
grid minor;
xlabel('Frequenz f [Hz]');
xlim([0 fs]);

%--------------------------------------------------------------------------
figure;
r = abs(fft(x));
scatter(n*fs/N, r);
grid on;
grid minor;
xlabel('Frequenz f [Hz]');
xlim([0 fs]);
