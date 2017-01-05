
%{
A = [ 1 2 3
      2 3 4
      3 4 5];
    
b = [ 7
      8
      9];

a = forward(L, b);
%}

m  = 20;   %
n  = 20;   %
dx = 1/(m+1);
dt = 0.001; % dt

%u = cell(1, m);
%u(:) = m^2/dt;
%r = cell(1, m-1);
%r(:) = { -1 };

%u = repelem(m^2/dt, 1, m);
%r = repelem(-1, 1, m-1);
%A = diag(u) + diag(r, 1) + diag(r, -1)

A = diag((2+dx^2/dt)*ones(m, 1)) + diag(-1*ones(m-1, 1), 1) + diag(-1*ones(m-1, 1), -1);

[L,R,P] = lu(A);

u = zeros(n, m+2);
u(1,(2:m+1))=ones(1,m);

for j=1:n-1
    b = P*dx^2 / dt * u(j, (2:m+1))';
    z = lr_forward(L,b);
    u(j+1,(2:m+1)) = lr_backward(R,z);
end

surf(u);

