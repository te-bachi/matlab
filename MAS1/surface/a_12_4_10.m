
close all;
clear;
clc;

len = 3;
f   = @(x, y) x*y;
x   = linspace(-len, len);
y   = linspace(-len, len);

for i = 1:length(y)
    z(:,i) = f(x, y(i));
end

mesh(x, y, z);
hold on;
axis vis3d;

v = [1,1];
figure;
contour(x,y,z,v);
hold on;
grid on;
axis normal;
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');

