

%%
clear all;
close all;
clc;

q = [1, 2, 3];
w = [7, 8];
p = [q, w];

%%
A = importdata('Cstep_fine.txt');
t = A(:,1)';
x = A(:,2)';

figure;
plot(t, x);

y = [0, diff(x)];
figure;
plot(t, y);

s     = sum(y);
%y_fft = fftshift(abs(fft(y))) / s;§
y_fft = abs(fft(y)) / s;
figure;
plot(t, y_fft);

N     = length(y_fft);
z_fft = y_fft(1:round(N/2));
t2    = t(1:round(N/2));
figure;
plot(t2, z_fft);    
grid on;
grid minor;

