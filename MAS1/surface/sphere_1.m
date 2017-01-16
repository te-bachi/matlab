
close all;
clear;
clc;

f = @(x, y) real(sqrt(2.^2 - x.^2 - y.^2));
x = linspace(-2, 2);
y = linspace(-2, 2);
z = zeros(length(x), length(y));

for i = 1:length(y)
    z(:,i) = f(x, y(i));
end

mesh(x, y, z);
hold on;
mesh(x, y, -z);

axis equal;
