%% Aufgabe 5
n=40;
m=5;
t=(1:n)';

A=ones(n,1);
x0=ones(m+1,1);
b=ones(n,1)*x0(1);

for i=(1:m)
    A = [A, t.^i];
    b = b + x0(i+1)*t.^i;
end

%% Aufgabe a)
L=chol(A'*A);
y=forward(L',A'*b);
x=backward(L,y);
norm(A*x-b)

%% Aufgabe b)
[q,r] = qr(A);

x1=backward(r((1:m+1),:),q(:,(1:m+1))'*b);
norm(A*x1-b)

%% Unterschied zwischen den beiden L?sungen

display('Cholesky: max. relativer Fehler = ')

norm((x-x0)./x0,'inf')

display('QR-Zerlegung: max. relativer Fehler = ')

norm((x1-x0)./x0,'inf')
