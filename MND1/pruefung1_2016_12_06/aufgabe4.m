
%clc;
clear;

% Messung
m       = 5;
x       = [   -4,   -2,    0,    2,    4 ]';
n       = [   53,  260,  405,   204,  67 ]';

% Modell
% x = Parameter fest
% x(1)
n       = 2;
f       = @(x, sigma)  x(1) * (1 - exp(-x(2) * t)); % (t, x) Parameter
F       = @(x)     f(t, x) - u;                 % (x)    Parameter, (t, u) GLOBAL!!

phi     = @(x)     0.5 * F(x)' * F(x);
dF      = @(x)     [ (1 - exp(-x(2) * t)),...
                     (x(1) * t .* exp(-x(2) * t)) ];
dphi    = @(x)     dF(x)' * F(x);

% Gauss-Newton-Verfahren
x0      = [2, 2]';
tol     = 10^-8;
iterMax = 200;
iter    = 0;
x       = x0;
while (norm(dF(x)' * F(x)) > tol) && (iter < iterMax)
    % Normalen Gleichung mit Hilfe der
    % QR-Zerlegung lösen
    A       = dF(x);
    b       = -F(x);
    [q, r]  = qr(A);
    s       = chol_backward(r(1:n,:), q'*b);
    
    % Parameter updaten
    x       = x + s;
    iter    = iter + 1;
end

xGN = x
