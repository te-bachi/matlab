
close all;
clc;
clear;

t   = linspace(-pi, pi, 1000);

set(groot, 'defaultAxesTickLabelInterpreter',   'latex');
set(groot, 'defaultLegendInterpreter',          'latex');
set(groot, 'defaultTextInterpreter',            'latex');

% f1
figure;
f1  = @(t) cos(2.*t) .* cos(1.*t);
f2  = @(t) cos(2.*t);
f3  = @(t) cos(1.*t);
y1  = f1(t);
y2  = f2(t);
y3  = f3(t);
plot(t, y3, 'Color', 'green', 'LineStyle', '--');
hold on;
plot(t, y2, 'Color', 'blue', 'LineStyle', '--');
plot(t, y1, 'Color', 'red', 'LineStyle', '-');
axis_set_pi();
legend('$$cos\left(1t\right)$$', '$$cos\left(2t\right)$$', '$cos \left ( 2 t \right ) \cdot cos \left ( 1  t \right )$');
fprintf('int(f1) = %f\n', integral(f1, -pi, pi));

% f2
f2  = @(t) cos(2.*t) .* cos(2.*t);
y2  = f2(t);
figure;
plot(t, y2, 'Color', 'green', 'LineStyle', '-');
grid on;
axis_set_pi();
legend('$cos \left ( 2 t \right ) \cdot cos \left ( 2  t \right )$');
fprintf('int(f2) = %f\n', integral(f2, -pi, pi));

% f3
f3  = @(t) cos(2.*t) .* cos(3.*t);
y3  = f3(t);
figure;
plot(t, y3, 'Color', 'black', 'LineStyle', '--');
grid on;
axis_set_pi();
legend('$cos \left ( 2 t \right ) \cdot cos \left ( 3  t \right )$');
fprintf('int(f3) = %f\n', integral(f3, -pi, pi));

% f4
f4  = @(t) cos(2.*t) .* cos(4.*t);
y4  = f4(t);
figure;
plot(t, y4, 'Color', [0.6 0.4 0.2], 'LineStyle', '-');
grid on;
axis_set_pi();
legend('$cos \left ( 2 t \right ) \cdot cos \left ( 4  t \right )$');
fprintf('int(f4) = %f\n', integral(f4, -pi, pi));

% f5
f5  = @(t) cos(2.*t);
y5  = f5(t);
figure;
plot(t, y5, 'Color', [0.2 0.6 0.4], 'LineStyle', '-');
grid on;
axis_set_pi();
legend('$cos \left ( 2  t \right )$');
fprintf('int(f5) = %f\n', integral(f5, -pi, pi));
