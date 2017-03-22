
clear all;
close all;
clc;

f   = @(x) x .* cos(x) + exp(x);
df  = @(x) cos(x) - x .* sin(x) + exp(x);

I_analytisch = pi/2 - 2 + exp(pi/2);

ns  = 2 .^ (2:10);

Ts  = [];
ET  = [];
ES  = [];
for n = ns
    h   = (pi / 2) / n;
    x   = linspace(0, pi/2, n + 1);

    % Trapezregel
    T   = h * (f(x(1)) / 2 + sum(f(x(2:end-1))) + f(x(end)) / 2);
    Ts  = [Ts, T];
    
    % wahrer Fehler
    ET  = [ET, abs(T - I_analytisch)];
    
    % Fehlerschätzung
    ES  = [ES, abs(h^2/12 * (df(pi/2) - df(0)))];
    
end

hs = pi/2 ./ ns;
loglog(hs, ET, 'o-');
hold on;
loglog(hs, ES, '--');
grid on;
grid minor;
daspect([1 1 1]);
