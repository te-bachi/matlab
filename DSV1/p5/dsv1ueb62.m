% =========================================================
% DSV1, Übung DFT-FFT, Aufgabe 2; 13.3.2009; Marcel Rupf
% Version: 22.10.2013
% =========================================================
clear; close all;

% Parameter
% =========================================================
fs=1000;    % Abtastfrequenz
W=8;        % Wortbreite Quantisierung

% dat-File lesen
% =========================================================
x=csvread('dsv1ueb62.dat');   
N=length(x) % Länge x-Vektor

% Plot verrauschtes Messsignal
% =========================================================
figure(1);
dtime=[0:N - 1] / fs; % <==  t = N / fs
plot(dtime,x,'LineWidth',2.0);
grid on;
grid minor;
xlabel('Zeit [s]');
ylabel('x[n]');
title('Messsignal plus Störung');
% print -dpng 1a; % Speichert das Bild in der Datei "1a.png" ab

% Plot Betragsspektrum
% =========================================================
X = fft(x);
XNdB=20*log10(abs(X/N));
f=[0:N-1]*(fs/N);
figure(2);
plot(f,XNdB,'o','LineWidth',2.0);
grid on;
grid minor;
xlabel('Frequenz [Hz]');
ylabel('abs(X)/N');
title('Betragsspektrum Messsignal plus Störung');
% print -dpng 1b;     % Speichert das Bild in der Datei "1b.png" ab

% Plot Messsignal ohne Störung
% =========================================================

fprintf('angle = %f\n', angle(X(21))); % angle = 1.048198 ==> 1.0472 = pi / 3 ??
X(21)  = 0;
X(181) = 0;
s=ifft(X);
figure(3);
plot(dtime,s,'LineWidth',2.0);
grid on;
grid minor;
xlabel('Zeit [s]');
ylabel('s[n]');
title('Messsignal ohne Störung');
% print -dpng 1d;     % Speichert das Bild in der Datei "1d.png" ab
