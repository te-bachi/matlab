% Aufgabe 1
% Newton Verfahren
f=@(x) x.^3-exp(1-x.*sin(x));
df=@(x) 3*x.^2+exp(1-x.*sin(x)).*(sin(x)+x.*cos(x));

xi=linspace(0,2,200);
plot(xi,f(xi))

% Startpunkt
x0=1.6;

tol=1e-12;
iterMax=20;
iter=0;
x=x0;
while abs(f(x))>tol && iter < iterMax
    x = x-f(x)/df(x);
    iter = iter+1;
end
x

hold on
plot(x,f(x),'ro')
