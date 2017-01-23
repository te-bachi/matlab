clear all;
m=320;  % Anzahl innere Punkte im Intervall [0,1]
n=2000; % Anzahl Zeitschritte

dx = 1/(m+1);
dt = 0.001;

TRand = @(k) 1*sin(20*pi*k*dt);

% Waermeleitungskoeffizient
lambda = 1;

% implizit
A=(lambda*2+dx^2/dt)*diag(ones(m,1))-lambda*diag(ones(m-1,1),-1)-lambda*diag(ones(m-1,1),1);
A(m,m) = lambda+dx^2/dt;

% Matlab LR-Zerlegung einmalig!
[L,R,P]=lu(A);

% implizite Loesungsmatrix
u = zeros(m+2,n);

% explizite Loesungsmatrix
% uex = zeros(m+2,n);
% uex(:,1) = u(:,1); % Anfangstemperatur

for j=1:n-1
    b = dx^2/dt*u(2:m+1,j);
    b(1) = b(1) + lambda*TRand(j);

% mit LR-Zerlegung
%    b = P*b;
%    z = forward(L,b);
%    u(2:m+1,j+1) = backward(R,z);

% oder viel schneller mit Solver f?r tridiagonal Matrizen:
    u(2:m+1,j+1) = tridiagsolver(diag(A),diag(A,-1),diag(A,1),b); % mex tridiagsolver.c
    u(1,j+1) = TRand(j);
    u(m+2,j+1) = u(m+1,j+1);
end

%surf(u)
%ylim([0,80])

%figure
%contour(u)

%figure
plot(u(end,:))
hold on
