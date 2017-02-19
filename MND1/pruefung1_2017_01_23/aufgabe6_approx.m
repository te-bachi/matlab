
aufgabe6_funktion;

f       = @(x) cos(x);

% Funktionen
% Funktion f(u) = 0
% x => u(1)
% y => u(2)
F       = @(u) [
    (u(1) - 1)^2 + (u(2) - 1)^2 - 2;
    u(2) - cos(u(1));
];

% Ableitung df/dx (x)
% syms x y;
% diff((x - 1)^2 + (y - 1)^2 - 2, x) => 2*x - 2
% diff((x - 1)^2 + (y - 1)^2 - 2, y) => 2*y - 2
% diff(y - cos(x), x)                => sin(x)
% diff(y - cos(x), y)                => 1
dF      = @(u) [
    2*u(1) - 2,   2*u(2) - 2;
    sin(u(1)),     1;
];

tol     = 1e-6; 
iterMax = 200;
iter    = 1;
error   = 1;
m       = 2;

%% Erster Punkt
x       = zeros(m, iterMax);

x(:, 1) = [ -0.5 f(0.5) ];

while error > tol && iter <= iterMax
    A           = dF(x(:, iter));
    b           = F(x(:, iter));
    [Q,R]       = qr(A);
    s           = chol_backward(R, Q'*b);
    x(:, iter + 1) = x(:, iter) - s;
    error       = norm(F(x(:, iter)));
    
    % y = x
    fprintf('(x%d/y%d) = %6.3f/%6.3f\n', iter, iter, x(1, iter), x(2, iter));
    iter        = iter + 1;
end

% y = x
scatter(x(1,iter), x(2, iter), 50, 'MarkerEdgeColor', 'red');


%% Zweiter Punkt
iter    = 1;
error   = 1;
x       = zeros(m, iterMax);

x(:, 1) = [ 2.0 f(2.0) ];

while error > tol && iter <= iterMax
    A           = dF(x(:, iter));
    b           = F(x(:, iter));
    [Q,R]       = qr(A);
    s           = chol_backward(R, Q'*b);
    x(:, iter + 1) = x(:, iter) - s;
    error       = norm(F(x(:, iter)));
    
    % y = x
    fprintf('(x%d/y%d) = %6.3f/%6.3f\n', iter, iter, x(1, iter), x(2, iter));
    iter        = iter + 1;
end

% y = x
scatter(x(1,iter), x(2, iter), 50, 'MarkerEdgeColor', 'blue');



