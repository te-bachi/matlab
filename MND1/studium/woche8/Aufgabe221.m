b = csvread('Messung.txt');

m=length(b)

ti=(1:m)';

A=[ones(m,1),ti,ti.^2,ti.^3,ti.^4,ti.^5];

L=chol(A'*A,'lower');
y=forward(L,A'*b);
xchol=backward(L',y)

[Q,R]=qr(A,0);

xqr=backward(R,Q'*b)

norm(A*xchol-b,'inf')
norm(A*xqr-b,'inf')

subplot(2,1,1)
plot(b,'.')
hold on
plot(A*xchol)
plot(A*xqr)

subplot(2,1,2)
plot(A*xchol-A*xqr)
