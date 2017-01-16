
close all;
clear;
clc;

% Funktionen
% Funktion f(x) = 0
f  = @(x) 1.5.*x.^3 - x + 0.3;
% Ableitung df/dx (x)
df = @(x) 4.5.*x.^2 - 1;

%% Original-Funktion berechen
x_f = linspace(-1,1);
y_f = f(x_f);
m_f = length(x_f);

%% Ausgeben Original-Funktion
p = plot(x_f, y_f, 'LineWidth', 1, 'Color', [0.0, 0.0, 0.0]);
px = gca;
hold on;
grid on;

% X-Achse
line(xlim, [0 0], 'Color', [1.0, 0.5, 0.0], 'LineWidth', 0.8);
% Y-Achse
line([0 0], ylim, 'Color', [1.0, 0.5, 0.0], 'LineWidth', 0.8);

% x = 0
scatter(0, f(0), 50, 'MarkerEdgeColor', 'green');


% Nullstellen von f(x)
x0  = roots([1.5 0 -1 0.3]);
y0  = zeros(1, length(x0));
for i = 1:length(x0)
    fprintf('(x0/y0) = %8.4f/%8.4f\n', x0(i), y0(i));
end
scatter(x0, y0, 75, 'MarkerEdgeColor', 'red');

% Nullstellen von df/dx (x)
dx0 = roots([4.5 0 -1]);
dy0 = f(dx0);
for i = 1:length(dx0)
    fprintf('(dx0/dy0) = %8.4f/%8.4f\n', dx0(i), dy0(i));
end
scatter(dx0, dy0, 50, 'MarkerEdgeColor', 'blue');




