clear all;
m=80;  % Anzahl innere Punkte im Intervall [0,1]
n=80; % Anzahl Zeitschritte

dx = 1/(m+1);
dt = 0.001;

% Stabilitaet fuer explizite Methode bedingt 
% dt/dx^2 < 1/2
% oder 
% dt <= 1/2*dx^2

% Waermeleitungskoeffizient
lambda = 1;

% implizit
A=(lambda*2+dx^2/dt)*diag(ones(m,1))-lambda*diag(ones(m-1,1),-1)-lambda*diag(ones(m-1,1),1);

% explizit
% Aex=(dx^2/dt-lambda*2)*diag(ones(m,1))+lambda*diag(ones(m-1,1),-1)+lambda*diag(ones(m-1,1),1);

% Matlab LR-Zerlegung einmalig!
[L,R,P]=lu(A);

% implizite Loesungsmatrix
u = zeros(m+2,n);
u(2:m+1,1) = ones(m,1); % Anfangstemperatur

% explizite Loesungsmatrix
% uex = zeros(m+2,n);
% uex(:,1) = u(:,1); % Anfangstemperatur

for j=1:n-1
    % implizite Methode
    b = P*dx^2/dt*u(2:m+1,j);
    z = forward(L,b);
    u(2:m+1,j+1) = backward(R,z);
    
    % explizite Methode
    % uex(2:m+1,j+1) = dt/dx^2*Aex*u(2:m+1,j);
end

% subplot(1,2,1)
surf(u)
% contour(u)

% subplot(1,2,2)
% surf(uex)
% zlim([0 1])
% 
% figure
% surf(uex-u)