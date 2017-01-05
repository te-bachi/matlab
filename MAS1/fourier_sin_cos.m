
close all;
clc;
clear;


set(groot, 'defaultAxesTickLabelInterpreter',   'latex');
set(groot, 'defaultLegendInterpreter',          'latex');
set(groot, 'defaultTextInterpreter',            'latex');


figure;
hold on;
subplot_m = 3;
subplot_n = 2;
                
t = linspace(-pi, pi, 1000);
k = 2;
for l = 0:(subplot_m * subplot_n) - 1
    f  = @(t) sin(k.*t) .* cos(l.*t);
    y  = f(t);
    subplot(subplot_m, subplot_n, l + 1);
    plot(t, y);
    axis_set_pi(false);
    grid on;
    legend(['$sin \left ( ', num2str(k), ' t \right ) \cdot cos \left ( ', num2str(l), '  t \right )$']);
    fprintf('int(f%d) = %f\n', l, integral(f, -pi, pi));
end
