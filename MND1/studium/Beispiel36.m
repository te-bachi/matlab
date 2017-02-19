f=@(x) 1./(1+x.^2);

n=20;
xi = linspace(-5,5,n+1)
h=xi(2)-xi(1);
fi = f(xi)

A=eye(n-1)*4+diag(ones(1,n-2),1)+diag(ones(1,n-2),-1)

b = (fi(1:end-2)-2*fi(2:end-1)+fi(3:end))*6/h^2

L=chol(A);
y=forward(L',b);
mi=[0; backward(L,y); 0]

x=linspace(-5,5,250);

y=splinePoly(x,xi,fi,mi);

plot(x,y,'--')
hold on
plot(x,f(x))
plot(xi,f(xi),'o')
