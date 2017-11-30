% ===========================================================
% DSV1, Übung 6, Aufgabe 3 Vorlage, Rumc
% ===========================================================
clear; close all;

% Parameter
% ===========================================================
fs=8000;        % Abtastfrequenz
f0=250;         % Frequenz Cosinus-Signal
N=64;           % Länge FFT
W=16;           % Wortbreite Quantisierung

% Cosinus-Signal
% ===========================================================
Ts=1/fs;
dtime=[0:N-1]*Ts;
x=cos(2*pi*f0*dtime);
xq=zeros(1,N);      % bitte überschreiben

% Plot Zeitsignal
% ===========================================================
figure(1)
dtime=[0:N-1]/fs;
plot(dtime,xq,'LineWidth',2.0); grid;
xlabel('Zeit [s]'); ylabel('Amplitude');

% FFT
% ===========================================================
X=zeros(1,N);       % bitte überschreiben
fachse=[0:N-1];     % bitte überschreiben

% Ausgabe
% ===========================================================
figure(2)
plot(fachse,X,'o','LineWidth',2.0); grid;
% axis([0 4000 -80 0])
% xlabel('Frequenz [Hz]');
% ylabel('abs(X[m])/N');
% title('DFT-Betragsspektrum (normiert)');