clear all, clc, close all
%kleinste Fehlerquadrate oder Normalengleichung
% linearen Ausgleichsproblems!!!!!!
% A^T*A*landa=A^T*y
% Die Lösung ist in der Form von ax+b
%Messpukte
%(x,y,z)
A=[-39.4 -64.4 21.1;-66.1 -91.3 19.5 ;-128.2 -65.3 21.0;45.5 -50 19.9;-144.6 51.6 21.5];

%erste Messwerte
y1=[0.000298 0.000421 0.000535*10 0.000213 0.000562]';
%t=0:3;
[m,n] = size(A);
%Löse die Gleichung im Sinne der Kleinstenfehlerquadrate
A1=A'*A;
y2=A'*y1;
%{
%Chol-Zerlegung
x2=LR_Chol_Solver(A1,y2)

%}

%QR-Zerlegung
[q,r]=qr(A1);
x1=backward(r,q'*y2)
Laenge=x1*300000
for i=1:n
    loesung=inv(A'*A)*A'*y1;
    a(i)=loesung(i);
end
a;

