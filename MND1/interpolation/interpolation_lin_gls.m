
clc;
clear;

x = [
   -1;
    0;
    1;
    2;
];

X = [
    x(1)^3, x(1)^2, x(1), 1;
    x(2)^3, x(2)^2, x(2), 1;
    x(3)^3, x(3)^2, x(3), 1;
    x(4)^3, x(4)^2, x(4), 1;
];

Y = [
    5;
   -2;
    9;
   -4;
];

A = X \ Y;
p = @(x) A(1)*x.^3 + A(2)*x.^2 + A(3)*x + A(4);

%% 
p_f    = @(x) -7*x.^3 + 9*x.^2 + 9*x - 2;
xmin = -1.5;
xmax = 2.5;
scatter(x, Y);
axis([xmin xmax -8 10]);
grid on;
hold on;
x_f = linspace(xmin, xmax);

% Ausgerechnet
y = p(x_f);
p2 = plot(x_f, y);
p2.LineWidth = 1.5;
p2.LineStyle = '-';
p2.Color     = 'red';

% Musterlösung
y_f = p_f(x_f);
p1 = plot(x_f, y_f, '--');
p1.LineWidth = 1.5;
p1.LineStyle = ':';
p1.Color     = 'blue';
