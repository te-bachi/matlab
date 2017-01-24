m=2000;
dx=1/(m+1);
n=100;
dt=0.001;

A=diag((2+dx^2/dt)*ones(m,1))+diag(-1*ones(m-1,1),-1)+diag(-1*ones(m-1,1),1);

fprintf('\nLR-Zerlegung\n');
tic
[L,R,P]=lu(A);
toc

fprintf('\nCholesky-Zerlegung\n');
tic
LC=chol(A,'lower');
toc

fprintf('\nSkript Vor-/Rueckwaerts Einsetzen\n');
u=zeros(n,m+2);
u(1,(2:m+1))=ones(1,m);
tic
for j=1:n-1
    b=P*dx^2/dt*u(j,(2:m+1))';
    z=forward1(L,b);
    u(j+1,(2:m+1))=backward1(R,z);
end
toc

fprintf('\nC-Code Vor-/Rueckwaerts Einsetzen\n');
tic
for j=1:n-1
    b=P*dx^2/dt*u(j,(2:m+1))';
    z=forward(L,b);
    u(j+1,(2:m+1))=backward(R,z);
end
toc

fprintf('\nC-Code (LT/RT) Vor-/Rueckwaerts Einsetzen\n');
LT=L';
RT=R';
tic
for j=1:n-1
    b=P*dx^2/dt*u(j,(2:m+1))';
    z=forwardT(LT,b);
    u(j+1,(2:m+1))=backwardT(RT,z);
end
toc

fprintf('\nMatlab Funktion Vor-/Rueckwaerts Einsetzen\n');
tic
for j=1:n-1
    b=P*dx^2/dt*u(j,(2:m+1))';
    opts.LT=true;
    opts.UT=false;
    z=linsolve(L,b,opts);
    opts.LT=false;
    opts.UT=true;
    u(j+1,(2:m+1))=linsolve(R,z,opts);
end
toc

fprintf('\nMatlab Solver\n');
tic
for j=1:n-1
    b=P*dx^2/dt*u(j,(2:m+1))';
    z=L\b;
    u(j+1,(2:m+1))=R\z;
end
toc

fprintf('\nTridiagonal-Solver C-Code\n');
tic
for j=1:n-1
    ad=diag(A);
    au=diag(A,1);
    al=diag(A,-1);
    b=P*dx^2/dt*u(j,(2:m+1))';
    u(j+1,(2:m+1))=tridiagsolver(ad,al,au,b);
end
toc

surf(u,'LineStyle','none')

