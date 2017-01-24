clear all

% Basisfunktionen
f = @(x) [ones(length(x),1) , x];

xi=(0:2)';

% Systemmatrix
A = f(xi)
% Messungen
b = [1,3,2]'

% Funktionen fuer die Berechnung der sinus, cosinus Werte
s = @(a11,a21) sign(a11) * a21/sqrt(a11^2+a21^2);
c = @(s) sqrt(1-s^2);

%% erste Spalte
% Eintrag A(2,1)
fprintf('1. Schritt: a21=0\n');
s1 = s(A(1,1),A(2,1))
c1 = c(s1)

Q1 = [c1, s1, 0; -s1, c1, 0; 0, 0, 1]

A1=Q1*A
pause

% Eintrag A(3,1)
fprintf('2. Schritt: a31=0\n');
s2 = s(A1(1,1),A1(3,1))
c2 = c(s2)

Q2 = [c2, 0, s2; 0, 1, 0; -s2, 0, c2]

A2=Q2*A1
pause

%% zweite Spalte
% Eintrag A(3,2)
fprintf('3. Schritt: a32=0\n');
s3 = s(A2(2,2),A2(3,2))
c3 = c(s3)

Q3 = [1, 0, 0; 0, c3, s3; 0, -s3, c3]

A3=Q3*A2
pause

% invers(Q) = Q^T
QT=Q3*Q2*Q1
pause

R=QT*A
pause

x=backward(R(1:2,:),QT(1:2,:)*b)
pause

xp = linspace(0,2,100);
plot(xp,x(1)*1+x(2)*xp)
hold on
plot(xi,b,'ro')
 
