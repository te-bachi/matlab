clear all

A=[1,0,0; 1,0,1;0,1,0]
b=[1;2;1]
xi=(0:2)';

% 1. Schritt
fprintf('1. Schritt: A(:,1) = lambda1 * e1\n');
y1=A(:,1)
e=eye(3);

v=y1+norm(y1)*e(:,1);

Hv = e-2*v*v'/(v'*v);
Q1=Hv

A1=Q1*A
pause

% 2. Schritt
fprintf('2. Schritt: A(2:end,2) = lambda2 * e2\n');
v=A1(2:end,2)+norm(A1(2:end,2))*e(2:end,2);

Q2=e;
Q2(2:end,2:end) = Q2(2:end,2:end)-2*v*v'/(v'*v);
Q2

A2=Q2*A1
pause
% Loesen der Gleichung
QT=Q2*Q1
pause
R=QT*A
pause

QT*b
pause

x = backward(A2,QT*b)
pause

