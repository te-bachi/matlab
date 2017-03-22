%% 1D-Kalman Filter
% Aufbau und Erläuterung nach Udacity Kurs CS373 taught by Sebastian Thrun
% Paul Balzer
clear all, clc
 
%% Ausgangsbedingungen
% sigma=Standardabweichung, m = Mittelwert
sigma_mess = 4; % Standardabweichung Messung
sigma_move = 2; % Standardabweichung Bewegung
 
mu = 0; % Startposition
sig = 10000; % Unsicherheit zu Beginn
 
%% Kalman-Berechnung
 
messung = [5, 6, 7, 9, 10];
bewegung= [1, 1, 2, 1, 1];
 
for i=1:length(messung)
 [mu,sig]=update_kalman(mu,sig,messung(i),sigma_mess);
 disp(['Update: ' num2str(mu) ', ' num2str(sig)])
 [mu,sig]=predict_kalman(mu,sig,bewegung(i),sigma_move);
 disp(['Predict: ' num2str(mu) ', ' num2str(sig)])
end