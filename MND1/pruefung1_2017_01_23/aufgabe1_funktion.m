
close all;
clear;
clc;

% Funktionen
% Funktion f(x) = 0
f  = @(x) x.^3 - exp(1 - (x .* sin(x)));
% Ableitung df/dx (x)
% syms x; diff(x^3 - exp(1 - (x * sin(x))))
df = @(x) 3.*x.^2 + exp(1 - x.*sin(x)).*(sin(x) + x.*cos(x));

%% Original-Funktion berechen
ival = [0 2];
x_f  = linspace(ival(1), ival(2));
y_f  = f(x_f);
m_f  = length(x_f);

%% Ausgeben Original-Funktion
p = plot(x_f, y_f, 'LineWidth', 1, 'Color', [0.0, 0.0, 0.0]);
hold on;
grid on;

% X-Achse
line(xlim, [0 0], 'Color', [1.0, 0.5, 0.0], 'LineWidth', 0.8);
% Y-Achse
line([0 0], ylim, 'Color', [1.0, 0.5, 0.0], 'LineWidth', 0.8);

% x = 0
scatter(0, f(0), 50, 'MarkerEdgeColor', 'green');



