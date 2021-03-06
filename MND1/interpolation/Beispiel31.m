
clear;
clc;

t = [  2,  4,  6,  8,  10 ];
T = [ 40, 20, 10,  6,   4 ];

l04 = @(x) ((x - 4).*(x - 6).*(x - 8).*(x - 10)) / ...
           ((2 - 4).*(2 - 6).*(2 - 8).*(2 - 10));
       
l14 = @(x) ((x - 2).*(x - 6).*(x - 8).*(x - 10)) / ...
           ((4 - 2).*(4 - 6).*(4 - 8).*(4 - 10));

l24 = @(x) ((x - 2).*(x - 4).*(x - 8).*(x - 10)) / ...
           ((6 - 2).*(6 - 4).*(6 - 8).*(6 - 10));

l34 = @(x) ((x - 2).*(x - 4).*(x - 6).*(x - 10)) / ...
           ((8 - 2).*(8 - 4).*(8 - 6).*(8 - 10));

l44 = @(x) ((x  - 2).*(x  - 4).*(x  - 6).*(x  - 8)) / ...
           ((10 - 2).*(10 - 4).*(10 - 6).*(10 - 8));

p   = @(x) T(1)*l04(x) + T(2)*l14(x) + T(3)*l24(x) + T(4)*l34(x) + T(5)*l44(x);

x = linspace(0,12);
plot(x, p(x));
hold on;
scatter(t, T);
