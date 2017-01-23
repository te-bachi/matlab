
clc;
clear;

%%
F    = @(x) [ (x(1)^3 - exp(1 - (x(1) * sin(x(1))))) ];
dF   = @(x) [ (x(1) * cos(x(1)) + sin(x(1)) * exp(1 - (x(1) * sin(x(1)))) + 3 * x(1)^2) ];
         
%%
x       = [ 1 ];
b       = [ 0 ];
tol     = 1e-8; 
error   = 1;
iterMax = 200;
iter    = 0;

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

xLoes = x

