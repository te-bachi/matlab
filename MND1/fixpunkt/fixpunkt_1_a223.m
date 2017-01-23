
close all;
clear all;
clc;

F       = @(u) [ 1/6 * cos(u(1))  + 1/3 * u(2);
                 1/8 * u(1) * u(2)^2 + 1/8 * sin(u(1)) ];

epsilon = 1;
tol     = 1e-8;
imax    = 200;
i       = 1;

%
% u0 = 0.0    u = 0.0  0.0  0.0  ...
%      0.0        0.0  0.0  0.0  ...
%
% u(:, 1) == u0:
% u(:, 1) = 0.0
%           0.0
u0      = [0.0; 0.0];
u       = zeros(length(u0), imax);
u(:, 1) = u0;

%
while (epsilon > tol) && (i <= imax)
    u(:, i + 1) = F(u(:, i));
    epsilon     = norm(u(:, i + 1) - u(:, i), 'inf');
    i           = i + 1;
end

% Residuum / Güte
r = norm(F(u(:, i)) - u(:, i), 'inf');


