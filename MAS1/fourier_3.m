
clc;
clear;

f = @(t) cos(2*2*pi*t);
t = linspace(0, 2, 1000);
y = f(t);

plot(t, y, 'Color', 'red');
hold on;
grid on;

line([0 0], ylim, 'Color', 'blue');
line(xlim, [0 0], 'Color', 'blue');