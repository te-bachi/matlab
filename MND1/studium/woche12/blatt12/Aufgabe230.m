%% Version (1)

F = @(x) [x(1)-21, x(2)-28, x(3)-12, sqrt(x(1)^2+x(2)^2)-34,...
    sqrt(x(1)^2+x(3)^2)-24, sqrt(x(1)^2+x(2)^2+x(3)^2)-38]';
dF = @(x) [1, 0, 0;
           0, 1, 0; 
           0, 0, 1; 
           x(1)/sqrt(x(1)^2+x(2)^2),x(2)/sqrt(x(1)^2+x(2)^2), 0;
           x(1)/sqrt(x(1)^2+x(3)^2),0,x(3)/sqrt(x(1)^2+x(3)^2);
           x(1)/sqrt(x(1)^2+x(2)^2+x(3)^2),x(2)/sqrt(x(1)^2+x(2)^2+x(3)^2),x(3)/sqrt(x(1)^2+x(2)^2+x(3)^2)];
phi = @(x) 0.5*F(x)'*F(x);
dphi = @(x) (dF(x)')*F(x);

n=3;
x0=[21,28,12]';

display('F(x0)');
F(x0)

display('dF(x0)')
dF(x0)

x=x0;
tol=1e-10;
maxIter=200;
iter=0;
ok=true;
res=[];
while ok && (iter < maxIter)
    Fi = F(x);
    dFi = dF(x);
    
    [q,r] = qr(dFi,0);
    s = backward(r,-q'*Fi);
    
    x = x+s;
    res = [res, norm(dphi(x),'inf')];
    if res(end) < tol
        ok=false;
    end
    iter = iter+1;
end
xGN1=x

%% Version (2)

F = @(x) [x(1)-21, x(2)-28, x(3)-12, sqrt(x(1)^2+x(2)^2)-34,...
    sqrt(x(2)^2+x(3)^2)-24, sqrt(x(1)^2+x(2)^2+x(3)^2)-38]';
dF = @(x) [1, 0, 0;
           0, 1, 0; 
           0, 0, 1; 
           x(1)/sqrt(x(1)^2+x(2)^2),x(2)/sqrt(x(1)^2+x(2)^2), 0;
           0,x(2)/sqrt(x(2)^2+x(3)^2),x(3)/sqrt(x(2)^2+x(3)^2);
           x(1)/sqrt(x(1)^2+x(2)^2+x(3)^2),x(2)/sqrt(x(1)^2+x(2)^2+x(3)^2),x(3)/sqrt(x(1)^2+x(2)^2+x(3)^2)];
phi = @(x) 0.5*F(x)'*F(x);
dphi = @(x) (dF(x)')*F(x);

n=3;
x0=[21,28,12]';

display('F(x0)');
F(x0)

display('dF(x0)')
dF(x0)

x=x0;
tol=1e-10;
maxIter=200;
iter=0;
ok=true;
res=[];
while ok && (iter < maxIter)
    Fi = F(x);
    dFi = dF(x);
    
    [q,r] = qr(dFi,0);
    s = backward(r,-q'*Fi);
    
    x = x+s;
    res = [res, norm(dphi(x),'inf')];
    if res(end) < tol
        ok=false;
    end
    iter = iter+1;
end
xGN2=x

