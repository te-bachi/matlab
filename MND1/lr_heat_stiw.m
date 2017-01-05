%m=2000;
m = 20;
dx=1/(m+1);
%n=100;
n=20;
dt=0.001;

A=diag((2+dx^2/dt)*ones(m,1))+diag(-1*ones(m-1,1),-1)+diag(-1*ones(m-1,1),1);

fprintf('\nLR-Zerlegung\n');
tic
[L,R,P]=lu(A);
toc

fprintf('\nSkript Vor-/Rueckwaerts Einsetzen\n');
u=zeros(n,m+2);
u(1,(2:m+1))=ones(1,m);
tic
for j=1:n-1
    b=P*dx^2/dt*u(j,(2:m+1))';
    z=lr_forward(L,b);
    u(j+1,(2:m+1))=lr_backward(R,z);
end
toc

%surf(u,'LineStyle','none')
surf(u)

