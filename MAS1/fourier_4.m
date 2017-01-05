
close all;
clc;
clear;

t   = linspace(-pi, pi, 1000);

set(groot, 'defaultAxesTickLabelInterpreter',   'latex');
set(groot, 'defaultLegendInterpreter',          'latex');
%set(groot, 'defaultTextInterpreter',            'latex');

% f1
figure;
f1  = @(t) sin(2.*t) .* cos(1.*t);
y1  = f1(t);
plot(t, y1, 'Color', 'red', 'LineStyle', '--');
axis_set('sin \left ( 2 t \right ) \cdot cos \left ( 1  t \right )');

% f2
f2  = @(t) sin(2.*t) .* cos(2.*t);
y2  = f2(t);
figure;
plot(t, y2, 'Color', 'green', 'LineStyle', '-');
grid on;
axis_set('');

% f3
f3  = @(t) sin(2.*t) .* cos(3.*t);
y3  = f3(t);
figure;
plot(t, y3, 'Color', 'black', 'LineStyle', '--');
grid on;
axis_set('');

% f4
f4  = @(t) sin(2.*t) .* cos(4.*t);
y4  = f4(t);
figure;
plot(t, y4, 'Color', [0.6 0.4 0.2], 'LineStyle', '-');
grid on;
axis_set('');
