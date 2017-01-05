
clc;
clear;

%%

F    = @(x) [ (-6*x(1) + 2*x(2)      + cos(x(1)));
              (-8*x(2) + x(1)*x(2)^2 + sin(x(1))) ];

dF   = @(x) [ (-6  - sin(x(1))),    (2);
              (x(2)^2 + cos(x(1))), (2*x(1)*x(2) - 8) ];
         
%%

x       = [ 0; 0];
b       = [ 0; 0];
tol     = 1e-8; 
error   = 1;
iterMax = 200;
iter    = 0;

%{
A     = dF(x);
b     = F(x);
xchol = chol(A, 'lower');
y     = chol_forward(xchol, b);
s     = chol_backward(xchol, y);
%}

while error > tol && iter < iterMax
    A       = dF(x);
    b       = F(x);
    [L,R,P] = lu(A);
    y       = lr_forward(L, b);
    s       = lr_backward(R, y);
    x       = x - s;
    error   = norm(s, 'inf');
    iter    = iter + 1;
end
