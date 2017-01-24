clear all
clc

b = csvread('Messung.txt');

% Datenreduktion fuer Step-by-Step Rechnung
b = b(1:150:end)
pause

ti = (1:length(b))';

% Polynom 5. Ordnung
deg = 3

A = [];
for i = 0:deg
    A = [A, ti.^i];
end

[m,n] = size(A);

%% QR-Zerlegung Given's Rotation
fprintf('QR-Zerlegung Givens Rotation\n');

A1=A;
QTGivens=eye(m);
for i=1:n
    for j=(i+1):m
        fprintf('(%d,%d)-Matrix Eintrag\n',i,j)
        s = sign(A1(i,i))*A1(j,i)/sqrt(A1(i,i)^2+A1(j,i)^2);
        c = sqrt(1-s^2);
        Qi = eye(m);
        Qi(i,i)=c;
        Qi(j,j)=c;
        Qi(i,j)=s;
        Qi(j,i)=-s;
        Qi
        
        A1 = Qi*A1
        pause
        QTGivens = Qi*QTGivens;
    end
end

RGivens = QTGivens*A;

% Loesen des Systems
fprintf('Loesen des Systems\n')
xGivens = backward(RGivens((1:n),:), QTGivens(1:n,:)*b)
pause


%% QR-Zerlegung mit Householder-Transformation
fprintf('QR-Zerlegung mit Householder-Transformation\n');

A1=A;
e = eye(m);
QTHouseholder=eye(m);
for i=1:n
    fprintf('%d.-Spalte\n',i)
    r=(i:m);
    w = A1(r,i) + sign(A1(i,i))*norm(A1(r,i))*e(r,i);
    H = e(r,r) - 2*w*w'/(w'*w);
    Qi = e;
    Qi(r,r) = H
    

    A1 = Qi*A1
    pause
    QTHouseholder = Qi*QTHouseholder;
end

RHouseholder = QTHouseholder*A;

% Loesen des Systems
fprintf('Loesen des Systems\n')
xHouseholder = backward(RHouseholder((1:n),:), QTHouseholder(1:n,:)*b)

pause

%% Visualisierung
tv = linspace(ti(1),ti(end))';
Av = [];
for i = 0:deg
    Av = [Av, tv.^i];
end

yGivens = Av*xGivens;
yHouseholder = Av*xHouseholder;
plot(ti,b,'o')
hold on
plot(tv,yGivens)
plot(tv,yHouseholder,'--')