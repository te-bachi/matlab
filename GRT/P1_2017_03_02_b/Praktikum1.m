%%GRT1, Praktikum1, Modellierung Wassertank
% 02.03.2017

%% Kennlinie des Niveausensors
close all;

% Messwerte
Usens = [0.16, 0.78, 1.42, 2.04, 2.69, 3.34, 3.97, 4.60, 5.21, 5.80, 6.45]; 
h = [0, 5, 10,  15, 20, 25, 30, 35, 40, 45, 50];

% Lineare regressions Werte
pp = polyfit(Usens, h, 1);       % Steigung und anfangswert U0 zu finden
linx = linspace(0, 7, 100);
linU = polyval(pp, linx);

% Steigung der funktion
m = pp(1);       % m=Steigung=h/Usens, U0=Ursprung

figure(1)
plot(linx, linU)
hold on
plot(Usens, h, 'o')
title('Kennlinie des Niveausensors');
xlabel('Spannung am Sensor: U[V]');
ylabel('Wasserhöhe im Tank: h[cm]');
grid minor

%% Kennlinie der Pumpe

%% Sprungantwort
load('data_q_8v.mat')
load('data_q_7v.mat')
load('data_q_6v.mat')
load('data_q_5v.mat')
load('data_q_4v.mat')

% Ausgangsspannungen vom Niveausensor
Ua_stationaere_8v = sum(data_q_8v.signals.values((end-100+1:end), 2))/100;   %Stationaere Zustand Ua[V] mit Eingangsspannung Ue = 8V
Ua_stationaere_7v = sum(data_q_7v.signals.values((end-100+1:end), 2))/100;   %Stationaere Zustand Ua[V] mit Eingangsspannung Ue = 7V
Ua_stationaere_6v = sum(data_q_6v.signals.values((end-100+1:end), 2))/100;   %Stationaere Zustand Ua[V] mit Eingangsspannung Ue = 6V
Ua_stationaere_5v = sum(data_q_5v.signals.values((end-100+1:end), 2))/100;   %Stationaere Zustand Ua[V] mit Eingangsspannung Ue = 5V
Ua_stationaere_4v = sum(data_q_4v.signals.values((end-100+1:end), 2))/100;   %Stationaere Zustand Ua[V] mit Eingangsspannung Ue = 4V

% Stationaere Höhe berechnen (m = proportionalitaetsfaktor)
h_stationaere_8v = m*Ua_stationaere_8v;
h_stationaere_7v = m*Ua_stationaere_7v;
h_stationaere_6v = m*Ua_stationaere_6v;
h_stationaere_5v = m*Ua_stationaere_5v;
h_stationaere_4v = m*Ua_stationaere_4v;

h_sationaere = [ h_stationaere_4v, h_stationaere_5v, h_stationaere_6v, h_stationaere_7v, h_stationaere_8v ];
Uin_p = [4,5,6,7,8];
pp1 = polyfit(Uin_p, h_sationaere, 2)       % Steigung und anfangswert U0 zu finden

linx1 = linspace(0, 7, 100);
linU1 = polyval(pp1, linx1);

% 
a = pp1(1)
h0 = pp1(3)

figure(3);
plot(linx1, linU1);
xlabel('Spannung an Vin_p [V]');
ylabel('Höhe [cm]');




