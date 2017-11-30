
clear all;
close all;
clc;

s = tf('s');
R = 1000;
C = 3.3 * 10^-9;

H = 1/(s^2 * C^2 * R^2 + 2 * s * C * R + 1);

W = logspace(4, 7, 1000);

%% / 180 * pi % kreisfrequenz


figure;
bode(H);
grid;
grid minor;

f = 100000;                     % 100 kHz
t = 0:1e-7:200e-6;
x = (1 + 0.8*sin(2*pi*f/10*t)) .* sin(2*pi*f*t);

figure;
lsim(H, x, t);
grid;
grid minor;

