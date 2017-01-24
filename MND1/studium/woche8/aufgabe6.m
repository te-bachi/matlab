clear all
clc

%% Berechnen der System-Matrix und Vektor b
r=(0:5);
ti = (1:40)';

A = []
for i=r
    A = [A, ti.^i];
end

[m,n] = size(A)

b = A(:,1);
for i=(2:n)
    b = b+A(:,i);
end

%% a)

L = chol(A'*A,'lower');
y = forward(L,A'*b);
xChol = backward(L',y)

%% b)

[Q,R] = qr(A,0);
xQR = backward(R(1:n,:),Q'*b)

%% c)

% die Loesung mit Hilfe der QR-Zerlegung ist praeziser als mit der
% Cholesky-Zerlgung:

norm(xChol - ones(n,1),'inf')
norm(xQR - ones(n,1),'inf')

% ebenso ist das Residuum (Fehlerquadrate) kleiner:
resChol = norm(A*xChol-b)^2
resQR = norm(A*xQR-b)^2


