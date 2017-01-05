
clc;
clear;

F       = @(u) [ 1/6 * cos(u(1))  + 1/3 * u(2);
                 1/8 * u(1) * u(2)^2 + 1/8 * sin(u(1)) ];
u0      = [0.0; 0.0];
usol    = [u0];
epsilon = 1;
tol     = 1e-8;
imax    = 200;
i       = 0;

% Beschränken auf 
while (epsilon > tol) && (i < imax)
    u1      = F(usol(:, end));
    epsilon = norm(u1 - usol(:, end), 'inf');
    usol    = [usol, u1];
    i       = i + 1;
end

% Residuum / Güte
r = norm(F(u1) - u1, 'inf');

r
usol

plot(usol');

%semilogy(1:n, d); hold on;
%semilogy(1:n, z); hold off;


delta = [];
for x = usol
    delta = [delta, norm(x - usol(:, end), 'inf')];
end

x      = delta(1:end - 2);
y      = delta(2:end - 1);

A      = [ ones(length(x), 1), ...
           log(x') ];
[Q, R] = qr(A);
w      = chol_backward(R(1:2,:), ...
                       Q' * log(y'));
%
w

