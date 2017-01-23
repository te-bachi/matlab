
clc;
clear;

% x(1) = "x"
% x(2) = "y"
F       = @(x) [ (1/4) * log(1 + x(2));
                 (1/2) * exp(-x(1)*x(2));];
x0      = [0.0; 0.0];
xsol    = [x0];
epsilon = 1;
tol     = 1e-3;
imax    = 200;
i       = 0;

while (epsilon > tol) && (i < imax)
    x       = F(xsol(:, end));
    epsilon = norm(x - xsol(:, end), 'inf');
    xsol    = [xsol, x];
    i       = i + 1;
end

xLoes = xsol(:, end)
iter  = i
