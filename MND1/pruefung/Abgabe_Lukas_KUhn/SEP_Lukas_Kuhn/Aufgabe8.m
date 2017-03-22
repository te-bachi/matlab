clear all, clc, close all
%kleinste Fehlerquadrate oder Normalengleichung
% linearen Ausgleichsproblems!!!!!!
% A^T*A*landa=A^T*y
% Die Lösung ist in der Form von ax+b
%Messpukte
%(x,y,z)
x=[24 26 30 35 38 39 39 37 35 31 27 24]
y=[37 33 29 29 34 38 41 43 46 48 47 44]
for n=1:12;
   
      A=[x(n)^2 x(n)*y(n) y(n)^2 2*x(n) 2*y(n)]
    
end
A=[576         888        1369          48          74;
     676         858        1089          52          66;
     900   870   841    60    58;
     1225        1015         841          70          58
   1444        1292        1156          76          68;
   1521        1482        1444          78          76;
   1521        1599        1681          78          82;
1369        1591        1849          74          86;
    1225        1610        2116          70          92;
    961        1488        2304          62          96;
   729        1269        2209          54          94;
   576        1056        1936          48          88]
   
%erste Messwerte
y1=[-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1]';
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

for i=1:n
    loesung=inv(A'*A)*A'*y1;
    a(i)=loesung(i);
end
%a

