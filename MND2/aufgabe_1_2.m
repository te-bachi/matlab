
f   = @(x) x .* cos(x) + exp(x);
df  = @(x) cos(x) - x .* sin(x) + exp(x);

I_analytisch = pi/2 - 2 + exp(pi/2);

ns  = 2 .^ (2:10);

n   = ns(1);
h   = (pi / 2) / n
x   = linspace(0, pi/2, n + 1);

% Trapezregel
T   = h * (f(x(1)) / 2 + sum(f(x(2:end-1))) + f(x(end)) / 2);

T
I_analytisch