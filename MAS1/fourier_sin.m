
close all;
clc;
clear;


set(groot, 'defaultAxesTickLabelInterpreter',   'latex');
set(groot, 'defaultLegendInterpreter',          'latex');
set(groot, 'defaultTextInterpreter',            'latex');

f1 = 'sin';

figure;
hold on;
subplot_m = 2;
subplot_n = 2;
                
t = linspace(-pi, pi, 1000);
for l = 0:(subplot_m * subplot_n) - 1
    f  = @(t) sin(l.*t);
    y  = f(t);
    subplot(subplot_m, subplot_n, l + 1);
    plot(t, y, 'LineWidth', 1.5);
    grid on;
    axis_set_pi(false);
    legend(['$\mathrm{', f1, '} \left ( ', num2str(l), '  t \right )$']);
    intpi = sprintf('%4.2f', abs(integral(f, -pi, pi)));
    fprintf('int(f%d) = %s\n', l, intpi);
    title(['$\int\limits_{-\pi}^{\pi} \mathrm{', f1, '} \left ( ', num2str(l), ' t \right ) \mathrm{d}t = ', intpi, '$']);
end
