
clc;
clear;

%u  = @(x) [,1) , x];


%{
A  = eye(n);
for i = 1:n
   for j = 1:n
      A(i,j) = A(i,j) +  1/n * (cos(4*pi*(i/n)*(j/n)))^2;
   end
end
%}

n       = 200;
x       = (1/n) * (1:n)'; % Stützstellen: 1/n, 2/n, 3/n, ..., n/n = 1
u0      = zeros(n,1);
A       = eye(n) + (1/n) * (cos(4*pi*x*x')).^2;
b       = ones(n, 1);
D       = diag(A);
invD    = diag(D.^(-1));
L       = tril(-A, -1);
R       = triu(-A, 1);

tol     = 1e-15; 
error   = 1;
iterMax = 200;
iter    = 0;
uSoll   = [u0]; % Jacobi

while error > tol && iter < iterMax
    uSoll = [uSoll (invD*(L+R)*uSoll(:,end) + invD * b)];
    error = norm(uSoll(:,end) - uSoll(:,end - 1), 'inf');
    iter  = iter + 1;
end

plot(x, uSoll(:,end));

Lchol = chol(A, 'lower');
y     = chol_forward(Lchol, b);
uchol = chol_backward(Lchol', y);

hold on;
plot(x, uchol(:,end)-0.01);
%hold off;

%% 2. Fall: p = 2
% Fixpunktfunktion
F        = @(x, u, p) (1 - 1/(n*p)*cos(4*pi*x*x').^2 * (u.^p));
uSollLin = [uchol]; % Lösung von linearem (p=1) als Startwert fürs nicht-lineare!
iter     = 0;
while error > tol && iter < iterMax
    % Fixpunkt-Iteration
    % u = F(u)
    uSollLin = [uSollLin F(x, uSollLin(:,end), 2)];
    error     = norm(uSollLin(:,end) - uSollLin(:,end - 1), 'inf');
    iter  = iter + 1;
end

plot(x, uSollLin(:,end)-0.02);
