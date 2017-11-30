% =============================================================
% DSV1, Uebung 6, Aufgabe 4 Vorlage, Rumc
% =============================================================
clear; close all;

% Parameter
% =============================================================
N=2048;

% Bestimmung r[n]
% =============================================================
r=zeros(1,N);       % bitte überschreiben
figure(1)
plot(r,'LineWidth',2.0); grid; 

% Bestimmung DFT R[m] und komplexe Fourierkoeffizienten cn
% =============================================================
c=zeros(1,N);       % bitte überschreiben

% Bildschirmausgabe
% =============================================================
figure(2)
stem([0:10],abs(c(1:11)),'filled'); grid;
xlabel('n (mal f0)');
ylabel('abs(cn)');
title('cn-Spektrum symmetrisches Rechtecksignal');

abs(c(1:11))