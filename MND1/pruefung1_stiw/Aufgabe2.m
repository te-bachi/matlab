% Aufgabe 2
% Fixpunkt Iteration
g=@(x) [1/4*log(1+x(2)); 1/2*exp(-x(1)*x(2))];

% Startpunkt
x0=[0;0];

tol=1e-12;
iterMax=50;
iter=0;
x=x0;
while norm(g(x)-x,'inf')>tol && iter < iterMax
    x = g(x);
    iter = iter+1;
end
x

