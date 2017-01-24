%% Aufgabe 1
% Simon Stingelin

%% Einlesen der Messdaten
% Import
data = importdata('MessungB61.txt');
% Anzahl Messungen
n=length(data)
% Abtastrate
fa=1/data(2,1);
% Zeitvektor
t=data(:,1);
data = data(:,2);

%% Grundfrequenz der Dreieckspannung
fmeas=20;
fnetz=50;

%% diskrete Fouriertransformation der Messung
% fft
fftdata = fft(data);

% Frequenzen in der fft
fi=linspace(0,fa,n);

absfft=abs(fftdata)/max(abs(fftdata));


%% lineare Ausgleichrechnung
% Berechnen der Matrix A
A=[cos(2*pi*fmeas*t), sin(2*pi*fmeas*t), cos(2*pi*fnetz*t), sin(2*pi*fnetz*t), ones(n,1), t, t.^2, t.^3];

% Cholesky-Zerlegung der Normalen Matrix
L=chol(A'*A);
b=A'*data;

% L?sen der Normalengleichung durch Vor-, R?ckw?rtseinsetzten
y = forward(L',b);
x = backward(L,y)

%% Visualisierung der Messdaten
figure
subplot(2,2,[1,2]);
plot(t,data)
hold on 
plot(t, sqrt(x(1)^2+x(2)^2)*sin(2*pi*fmeas*t+atan(x(1)/x(2))),'r')
plot(t, x(1)*cos(2*pi*fmeas*t)+x(2)*sin(2*pi*fmeas*t),'o')
title('Messdaten')

subplot(2,2,3);
plot(t, sqrt(x(1)^2+x(2)^2)*sin(2*pi*fmeas*t+atan(x(1)/x(2))),'r')
hold on
plot(t, abs(2/501*fftdata(20/2+1))*cos(2*pi*fmeas*t+angle(2/501*fftdata(20/2+1))),'g')
title('Vergleich lin Fit, FFT Loesung')

subplot(2,2,4);
semilogy(fi(absfft>0),absfft(absfft>0),'.')
axis([0,100,1e-2,1])
title('Abs(fft)')
