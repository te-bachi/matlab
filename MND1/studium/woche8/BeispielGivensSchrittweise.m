%% Problem
A=[1,0; 1,1; 1, 2]
b=[1;3;2]

% Matrix der Aufgabe 2
A=[1,2; 2,3; 3, 1]
b=[3;5;4]

%% 1. Spalte
i=1;
% j=2
j=2;
Q1=eye(3);
s=sign(A(i,i))*A(j,i)/sqrt(A(i,i)^2+A(j,i)^2);
c=sqrt(1-s^2);
Q1(i,i)=c;Q1(j,j)=c;
Q1(i,j)=s;Q1(j,i)=-s;

A1=Q1*A

% j=3
j=3;
Q2=eye(3);
s=sign(A1(i,i))*A1(j,i)/sqrt(A1(i,i)^2+A1(j,i)^2);
c=sqrt(1-s^2);
Q2(i,i)=c;Q2(j,j)=c;
Q2(i,j)=s;Q2(j,i)=-s;

A2=Q2*A1

%% 2. Spalte
i=2;
% j=3
j=3;
Q3=eye(3);
s=sign(A2(i,i))*A2(j,i)/sqrt(A2(i,i)^2+A2(j,i)^2);
c=sqrt(1-s^2);
Q3(i,i)=c;Q3(j,j)=c;
Q3(i,j)=s;Q3(j,i)=-s;

A3=Q3*A2

% Loesen der Gleichung
% Zusammengesetzte orthogonale Matrix
QT=Q3*Q2*Q1;

% Rechte Seite von Ax=b => Rx=Q^Tb
QTb = QT(1:2,:)*b

% Loesen durch Rueckwaertseinsetzen
x = backward(A3(1:2,1:2),QTb)
