clear all;
clc;

n=500;
x=1/n*(1:n)';

u0 = ones(n,1);

%% 1. Fall p=1
A = eye(n) + 1/n * cos(4*pi*x*x').^2;
b = ones(n,1);

D = diag(A);
invD = diag(D.^(-1));

L = -tril(A,-1);
R = -triu(A,1);

tol = 1e-14;
error = 1;
iterMax = 200;
iter = 0;
uSolJacobi = [u0];
while error > tol && iter < iterMax
    % Jacobi-Verfahren
    uSolJacobi = [uSolJacobi (invD*(L+R)*uSolJacobi(:,end) + invD*b)];
    
    error = norm(uSolJacobi(:,end)-uSolJacobi(:,end-1),'inf');
    iter = iter + 1;
end
figure
subplot(1,2,1)
plot(x,uSolJacobi(:,end))

Lchol = chol(A,'lower');

y = forward(Lchol, b);
uchol = backward(Lchol',y);

hold on
plot(x,uchol(:,end),'--')

%% 2. Fall p = 2 Fixpunkt-Iteration
% Fixpunktfunktion:
F = @(x,u,p) 1-1/(n*p)*cos(4*pi*x*x').^2*(u.^p);

uSolnonlin = [uchol];

% Problem Vorlesungsskript
error = 1; % <= fehlt, alter Fehler ueberschreiben!!!
while error > tol && iter < iterMax
    % Fixpunkt-Iteration
    % u = F(u)
    u = F(x,uSolnonlin(:,end),2);
    uSolnonlin = [uSolnonlin u];
    
    error = norm(uSolnonlin(:,end)-uSolnonlin(:,end-1),'inf');
    iter = iter + 1;
end
plot(x,uSolnonlin(:,end))

%% 2. Fall p = 2
% Newton-Iteration:
FN = @(x,u,p) u+1/(n*p)*cos(4*pi*x*x').^2*(u.^p)-1;
JFN = @(x,u,p) eye(n)+1/n*cos(4*pi*x*x').^2*diag((u.^(p-1)));

uSolnonlinNewton = [uchol];
error = 1;
while error > tol && iter < iterMax
    % Newton-Iteration
    ualt = uSolnonlinNewton(:,end);
    % jacf s = f
    A = JFN(x,ualt,2);
    b = FN(x,ualt,2);
    [L,R,P] = lu(A);
    y = forward(L,P*b);
    s = backward(R,y);

    % xneu = xalt - s
    u = ualt - s;
    uSolnonlinNewton = [uSolnonlinNewton u];
    
    error = norm(s,'inf');
    iter = iter + 1;
end
plot(x,uSolnonlinNewton(:,end),'--')

%% Konvergenz-Ordnung
% Fixpunkt-Iterartion
epsilonI = [];
for x = uSolnonlin
    epsilonI = [epsilonI, norm(x-uSolnonlinNewton(:,end),'inf')];
end
x = epsilonI(1:end-3)';
y = epsilonI(2:end-2)';
A = [ones(length(x),1), log(x)];
[Q,R] = qr(A,0);
w=backward(R(1:2,:),Q'*log(y));
fprintf('Konvergenz-Ordnung Fixpunkt-Iteration: p=%f\n', w(2))

epsilonN = [];
for x = uSolnonlinNewton
    epsilonN = [epsilonN, norm(x-uSolnonlinNewton(:,end),'inf')];
end
x = epsilonN(1:end-3)';
y = epsilonN(2:end-2)';
A = [ones(length(x),1), log(x)];
[Q,R] = qr(A,0);
w=backward(R(1:2,:),Q'*log(y));
fprintf('Konvergenz-Ordnung Newton-Verfahren  : p=%f\n', w(2))

subplot(1,2,2)

semilogy(epsilonI)
hold on
semilogy(epsilonN)
legend('Fixpunkt','Newton')
