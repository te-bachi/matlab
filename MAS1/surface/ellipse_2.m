
close all;
clear;
clc;

a = 3;
b = 2;
if (a > b)
    len = a*2;
else
    len = b*2;
end

f = @(x, y) x.^2/a^2 + y.^2/b^2;
x = linspace(-len, len);
y = linspace(-len, len);
[A, B] = meshgrid(x, y);

for i = 1:length(y)
    z(:,i) = f(x, y(i));
end

mesh(x, y, z);
hold on;
axis equal;

v = [2,2];
figure;
contour(x,y,z,v);
hold on;
grid on;
axis equal;
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');
scatter([3], [2], 'MarkerEdgeColor', 'red');
