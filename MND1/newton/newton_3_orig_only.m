
clear;
clc;

% Funktionen
f  = @(x) 1.5.*x.^3 - x + 0.3;

%% Original-Funktion berechen
x_f = linspace(-1,1);
y_f = f(x_f);
m_f = length(x_f);

%% Ausgeben Original-Funktion
p = plot(x_f, y_f, 'LineWidth', 1, 'Color', [0.0, 0.0, 0.0]);
px = gca;
hold on;
grid on;

% Achsen
axis_x = xlim;
axis_y = ylim;
xmin   = axis_x(1);
xmax   = axis_x(2);
ymin   = axis_y(1);
ymax   = axis_y(2);


% Null-Linie
plot([xmin xmax], [0, 0], 'Color', [1.0, 0.5, 0.0]);


% Nullstellen
x0 = roots([1.5 0 -1 0.3]);
y0 = zeros(1, length(x0));
scatter(x0, y0, 75, 'MarkerEdgeColor', 'red');



