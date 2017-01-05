
%clc;
clear;

% Messung
m       = 4;
t       = [    0,    1,    2,    3 ]';
u       = [ 0.00, 0.63, 0.86, 0.95 ]';

% Modell
% a = x(1)
% b = x(2)
n       = 2;
f       = @(t, x)  x(1) * (1 - exp(-x(2) * t)); % (t, x) Parameter
F       = @(x)     f(t, x) - u;                 % (x)    Parameter, (t, u) GLOBAL!!

phi     = @(x)     0.5 * F(x)' * F(x);
dF      = @(x)     [ (1 - exp(-x(2) * t)),...
                     (x(1) * t .* exp(-x(2) * t)) ];
HF      = @(t, x)  [ 0,                  (t.*exp(-x(2)*t));...
                     (t.*exp(-x(2)*t)),  -x(1)*t.^2.*exp(-x(2)*t) ];
                
dphi    = @(x)     dF(x)' * F(x);

% Newton-Verfahren
x0      = [1.5, 1.5]';
tol     = 10^-8;
lambdaMin = 1e-4;
iterMax = 200;
iter    = 0;
x       = x0;
while (norm(dF(x)' * F(x)) > tol) && (iter < iterMax)
    % Normalen Gleichung mit Hilfe der
    % QR-Zerlegung lösen
    A       = dF(x)' * dF(x);
    c       = F(x);
    for i = 1:m
        A = A + c(i) * HF(t(i), x);
    end
    b       = -dF(x)' * F(x);
    [q, r]  = qr(A);
    s       = chol_backward(r(1:n,:), q'*b);
    
    % Parameter updaten mit Dämpfung
    xn      = x + s;
    lambda = 1;
    while (phi(xn) > phi(x)) && (lambda > lambdaMin)
        lambda  = lambda / 2;
        xn      = x + (lambda * s);
    end
    x       = xn;
    iter    = iter + 1;
end

xN = x
