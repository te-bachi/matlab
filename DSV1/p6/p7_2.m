clear;
clc;
close all;

fs = 48e3;
f0 = 50;
t  = 0:1/fs:0.2;

s  = 2 * sin(2*pi*f0*t + pi/2);
r  = randn(1,length(s)) * 10; % Weisses Rauschen
x  = s+r;

% Signale
figure;

subplot(3,1,1);
plot(t,s,'r','LineWidth',2);
grid on;
xlabel('t \rightarrow [s]');
ylabel('Signal s \rightarrow ');

subplot(3,1,2);
plot(t,r,'r','LineWidth',2);
grid on;
xlabel('t \rightarrow [s]');
ylabel('Rauschen r \rightarrow ');

subplot(3,1,3);
plot(t,x,'r','LineWidth',2);
grid on;
xlabel('t \rightarrow [s]');
ylabel('Verrauschter Sinus x=s+r \rightarrow ');

% Spektren
S = fft(s)/length(x);
R = fft(r)/length(x)
X = fft(x)/length(x);
f = linspace(0,fs,length(x));

figure;

subplot(3,1,1);
semilogx(f,20*log10(abs(S)),'r','LineWidth',2);
grid on;
xlabel('f \rightarrow [Hz]');
ylabel('Spektrum S \rightarrow [dB]');
axis([10 fs/2 -100 20])

subplot(3,1,2);
semilogx(f,20*log10(abs(R)),'r','LineWidth',2);
grid on;
xlabel('f \rightarrow [f_s]');
ylabel('Spektrum R \rightarrow [dB]');
axis([10 fs/2 -60 20])

subplot(3,1,3);
semilogx(f,20*log10(abs(X)),'r','LineWidth',2);
grid on;
xlabel('f \rightarrow [f_s]');
ylabel('Spektrum X \rightarrow [dB]');
axis([10 fs/2 -60 20])
