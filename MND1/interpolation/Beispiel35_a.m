

clear;
clc;

% f(x) = 1 / (1 + x^2)

n = 16;
j = 0:1:n;
x = -5 + 10 * (j/n);
f = @(x) 1 ./ (1 + x.^2);
y = f(x);


plot(x, y);
hold on;
scatter(x, y);