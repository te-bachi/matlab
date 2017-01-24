%% Problem
A=[1,0; 1,1; 1, 2]
b=[1;3;2]

% Matrix der Aufgabe 2
A=[1,2; 2,3; 3, 1]
b=[3;5;4]

%% 1. Schritt
y1=A(:,1)
e=eye(3);

% Vektor v
v=y1+norm(y1)*e(:,1);

%Householder Transformationsmatrix
Hv = e-2*v*v'/(v'*v);

% Orthogonale Matrix
Q1=Hv;

% Anwenden auf A
A1=Q1*A

%% 2. Schritt
y2=A1(2:end,2)
e=eye(2);

% Vektor v
v=y2+norm(y2)*e(:,1);

% Orthogonale Matrix
Q2=eye(3);
Q2(2:end,2:end) = Q2(2:end,2:end)-2*v*v'/(v'*v);

% Anwenden auf A1
A2=Q2*A1

% Loesen der Gleichung
% Zusammengesetzte orthogonale Matrix
QT=Q2*Q1;

% Rechte Seite von Ax=b => Rx=Q^Tb
QTb = QT(1:2,:)*b

% Loesen durch Rueckwaertseinsetzen
x = backward(A2(1:2,1:2),QTb)
