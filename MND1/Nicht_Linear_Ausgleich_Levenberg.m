
clc;
clear;

% Messung
t       = [    0,    1,    2,    3 ]';
u       = [ 0.00, 0.63, 0.86, 0.95 ]';
m       = length(u);

% Modell
% a = x(1)
% b = x(2)
n       = 2;
f       = @(t, x)  x(1) * (1 - exp(-x(2) * t)); % (t, x) Parameter
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
mu      = 1;
ok      = true;
resL    = [];
beta0   = 0.2;
beta1   = 0.8;
while ok && (iter < iterMax)
    % lineares Ausgleichsproblem
    Fi      =  [  F(x)', zeros(1, n) ]';
    dFi     =  [ dF(x)', mu * eye(n) ]';
    
    [q, r]  = qr(dFi);
    s       = chol_backward(r(1:n,:), -q(:,1:n)'*Fi);
    
    % Korrektur fuer die naechste Iteration
    xn      = x + s;
    
    rho     = (norm(F(x))^2 - norm(F(xn))^2) / (norm(F(x))^2 - norm(F(x) + dF(x) * s)^2);
    
    if rho < beta0
        % Vergroessere mu
        % und akzeptiere den Schritt NICHT!
        mu      = mu*2;
    else
        if rho > beta1
            % Verkleinere mu
            mu  = mu / 2;
        end
        % Parameter updaten
        x       = xn;
        
        % Akzeptiere die Loesung
        resL    = [resL, norm(dphi(x), 'inf') ];
        if resL(end) < tol
            ok = false;
        end
    end
    
    iter    = iter + 1;
end

xGN = x
