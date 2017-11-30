% ========================================================
% Uebung 6, Aufgabe 5, 20.3.2009, Rumc
% ========================================================
clear; close all;

% Parameter
% ========================================================
fs=10000;   % Abtastfrequenz
N=800;      % Anzahl Samples

% gemessenes Signal (gegeben!)
% =======================================================
f0=105;     
alpha=0.995;
x=alpha.^[0:N-1].*cos(2*pi*f0*[0:N-1]/fs)+0.05*randn(1,N);

figure(1)
dtime=[0:N-1]/fs;
plot(dtime,x); grid;
xlabel('Zeit [s] (fs=10 kHz)');

% f0 bestimmen
% ======================================================
