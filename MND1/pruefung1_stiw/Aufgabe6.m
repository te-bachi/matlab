% Aufgabe 6
% Newton Verfahren
f=@(x) [(x(1)-1)^2+(x(2)-1)^2-2; x(2)-cos(x(1))];
df=@(x)[2*(x(1)-1), 2*(x(2)-1); sin(x(1)), 1];

% Startpunkt PT1
x0=[-.2,.8]';

tol=1e-12;
iterMax=20;
iter=0;
x=x0;
while norm(f(x))>tol && iter < iterMax
    [q,r] = qr(df(x));
    s = backward(r, q'*f(x));
    x = x-s;
    iter = iter+1;
end
pt1=x


% Startpunkt PT2
x0=[1.2,0]';

tol=1e-12;
iterMax=20;
iter=0;
x=x0;
while norm(f(x))>tol && iter < iterMax
    [q,r] = qr(df(x));
    s = backward(r, q'*f(x));
    x = x-s;
    iter = iter+1;
end
pt1=x


