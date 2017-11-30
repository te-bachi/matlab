
clear all;
close all;
clc;

%--------------------------------------------------------------------------
% Gegeben: fs + N
% Rechnet: T
f0   = 50;    % f0 = 1000, 1100, 1200 !!!!
fs   = 100;
N    = 128;
T    = (N-1)/fs;

%--------------------------------------------------------------------------
n    = [0:1:N-1];
t    = [0:1/fs:T];
Ts   = 1/fs;
Tdft = fs * N;
x    = [1:1:128];
df   = fs / N;

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
% Figure 1
figure;
subplot(2,1,1);
title('Zeitbereich');
scatter(t, x);
hold on;
plot(t, x);
grid on;
grid minor;
xlabel('Zeit t [s]');
xlim([0 T]);
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);

subplot(2,1,2);
scatter(n, x);
hold on;
plot(n, x);
grid on;
grid minor;
xlabel('Abtastwerte n [#]');
xlim([0 N-1]);
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);

%--------------------------------------------------------------------------
% Figure 2
figure;

subplot(3,1,1);
s = real(y);
scatter(n*fs/N, s);
hold on;
plot(n*fs/N, s);
grid on;
grid minor;
xlabel('Frequenz f [Hz]');
ylabel('Real');
xlim([0 fs]);
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);
ax = gca;
ax.XTick = [0:df:fs];

subplot(3,1,2);
s = imag(y);
scatter(n*fs/N, s);
hold on;
plot(n*fs/N, s);
grid on;
grid minor;
xlabel('Frequenz f [Hz]');
ylabel('Imaginär j');
xlim([0 fs]);
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);
ax = gca;
ax.XTick = [0:df:fs];

subplot(3,1,3);
s = abs(y);
scatter(n*fs/N, s);
hold on;
plot(n*fs/N, s);
grid on;
grid minor;
xlabel('Frequenz f [Hz]');
ylabel('Absolut |X|');
xlim([0 fs]);
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);
ax = gca;
ax.XTick = [0:df:fs];

