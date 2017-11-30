
clear all;
close all;
clc;

%--------------------------------------------------------------------------
% Gegeben: fs + N
% Rechnet: T
f0   = 250;
fs   = 1000;
N    = 4;
%--------------------------------------------------------------------------
T    = (N-1)/fs;    % 0.0030
Ts   = 1/fs;        % 0.0010
Tdft = fs * N;      % 4000
df   = fs / N;      % 250

n    = [0:1:N-1];   %
t    = [0:1/fs:T];  %
x    = 2*cos(2 * pi * f0 * n / fs);

fprintf('len(n) = %d\n',    length(n));
fprintf('len(t) = %d\n',    length(t));
fprintf('len(x) = %d\n',    length(x));
fprintf('fs     = %d\n',    fs);
fprintf('N      = %d\n',    N);
fprintf('T      = %1.4f\n', T);
fprintf('Ts     = %1.4f\n', 1/fs);
fprintf('Tdft   = %d\n',    Tdft);
fprintf('df     = %d\n',    df);

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
ylim([min(x) max(x)]);
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);

subplot(2,1,2);
scatter(n, x);
hold on;
plot(n, x);
grid on;
grid minor;
xlabel('Abtastwerte n [#]');
xlim([0 N-1]);
ylim([min(x) max(x)]);
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

