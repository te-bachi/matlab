
clear;
clc;

t = (0:5)';
A = [ ones(6,1), 1./(1 + t.^2) ];
b = [1/2; 3/4; 9/10; 19/20; 33/34; 51/52 ];
L = chol(A'*A, 'lower');

y = lr_forward(L,A'*b);
x = lr_backward(L', y);

f =@(t) x(1) + x(2) * (1 ./ (1+t.^2));
plot(t, b, 'o');
tg = linspace(0,5);
hold on;
plot(tg, f(tg));
