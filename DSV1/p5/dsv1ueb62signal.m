% =========================================================
% DSV1, Uebung 6, Aufgabe 1 L�sung, Rur
% =========================================================
clear; close all;

% Parameter
% =========================================================
FS=1000;
F0=10;
FI=100;
N=200;
NSPB=FS/F0;
NP=N/NSPB;
W=8;

% dreieckf�rmiges Messsignal
% =========================================================
s=[0:NSPB/4-1 NSPB/4:-1:1]; s=[s -s]; s=0.5*s/max(abs(s));
s=kron(ones(1,NP),s);

% St�rung und Quantisierung
% =========================================================
z=0.125*cos(2*pi*FI*[0:N-1]/FS + pi/3);
x=s+z;
x=round(x/2^(1-W))*2^(1-W);

% als wave-Datei speichern
% =========================================================
%wavwrite(x,FS,8,'dsv1ueb51');
csvwrite('dsv1ueb51.dat',x);
