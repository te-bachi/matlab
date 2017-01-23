
aufgabe1_funktion;


% Funktionen
% Funktion f(x) = 0
F       = @(x) [ x(1)^3 - exp(1 - (x(1) * sin(x(1)))) ];

% Ableitung df/dx (x)
% syms x; diff(x^3 - exp(1 - (x * sin(x))))
dF      = @(x) [ 3*x(1)^2 + exp(1 - x(1)*sin(x(1)))*(sin(x(1)) + x(1)*cos(x(1))) ];

tol     = 1e-6; 
error   = 1;
iterMax = 200;
iter    = 1;

x       = zeros(1, iterMax);
b       = zeros(1, iterMax);
s       = zeros(1, iterMax);

x(1) = 0.5;

while error > tol && iter <= iterMax
    A           = dF(x(iter));
    b(iter)     = F(x(iter));
    [L,R,P]     = lu(A);
    y           = lr_forward(L, b(iter));
    s(iter)     = lr_backward(R, y);
    x(iter + 1) = x(iter) - s(iter);
    error       = norm(s(iter), 'inf');
    
    % y = 0
    scatter(x(iter), f(x(iter)), 50, 'MarkerEdgeColor', [255/255 (255 - iter * 50)/255 0]);
    fprintf('(x%d/y%d) = %6.3f/%6.3f\n', iter, iter, x(iter), f(x(iter)));
    iter        = iter + 1;
end

% y = 0
scatter(x(iter), f(x(iter)), 50, 'MarkerEdgeColor', 'red');



