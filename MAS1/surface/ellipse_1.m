
close all;
clear;
clc;

a = 3;
b = 2;
f = @(x) real(sqrt(b^2 - (b^2/a^2) * x.^2));
if (a > b)
    len = a;
else
    len = b;
end
x = linspace(-len, len);
y = f(x);

plot(x, y);
hold on;
grid on;
plot(x, -y);
axis([-a-1 a+1 -b-1 b+1]);
axis equal;

line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');
scatter([a -a], [0 0], 'MarkerEdgeColor', 'red');
