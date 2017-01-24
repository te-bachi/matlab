t=[0.1,0.3,0.7,1.2,1.6,2.2,2.7,3.1,3.5,3.9]';
b=[0.558,0.569,0.176,-0.207,-0.133,0.132,0.055,-0.090,-0.069,0.027]';

f = @(t,x) x(1)*exp(-x(2)*t).*sin(x(3)*t+x(4));
df = @(t,x) [exp(-x(2)*t).*sin(x(3)*t+x(4)), -t*x(1).*exp(-x(2)*t).*sin(x(3)*t+x(4)), x(1)*exp(-x(2)*t).*t.*cos(x(3)*t+x(4)), x(1)*exp(-x(2)*t).*cos(x(3)*t+x(4))];

n=4;

F = @(x) (f(t,x)-b);
dF = @(x) df(t,x);
phi = @(x) 0.5*F(x)'*F(x);
dphi = @(x) (dF(x)')*F(x);
d2phi = @(x) (dF(x)'*dF(x)+d2phiBeispiel222(t,x,b));

x0=[1,2,2,1]';

display('phi(x0)');
phi(x0)

display('dphi(x0)')
dphi(x0)

%% Gauss-Newton-Verfahren
tic
x=x0;
tol=1e-10;
maxIter=200;
iter=0;
ok=true;
res=[];
while ok && (iter < maxIter)
    Fi = F(x);
    dFi = dF(x);
    
    [q,r] = qr(dFi);
    s = backward(r(1:n,:),-q(:,1:n)'*Fi);
    
    x = x+s;
    res = [res, norm(dphi(x),'inf')];
    if res(end) < tol
        ok=false;
    end
    iter = iter+1;
end
xGN=x;
toc

display('phi(x0)');
phi(x0)

display('dphi(x0)')
dphi(x0)

%% Newton-Verfahren
tic
x0=[1,1,3,1]';

lambdamin=1e-8;
x=x0;
tol=1e-10;
maxIter=200;
iter=0;
ok=true;
res2=[];
damping=[];
while ok && (iter < maxIter)
    phix = phi(x);
    gradPhi = dphi(x);
    HPhi = d2phi(x);
    
    [q,r] = qr(HPhi);
    s = backward(r,q'*gradPhi);
    xn = x-s;
    % einfaches gedaempftes Verfahren phi soll minimiert werden:
    lambda = 1;
    while (phi(xn) > phix) && (lambda >= lambdamin)
        lambda = lambda/2;
        xn = x-lambda*s;
    end
    damping = [damping, lambda];
    x=xn;

    res2 = [res2, norm(dphi(x),'inf')];
    if res2(end) < tol
        ok=false;
    end
    iter = iter+1;
end
xN=x
toc

figure
subplot(1,2,1)
tp=linspace(0,4,200);
plot(tp,f(tp,x0))
hold on
plot(t,b,'o')
plot(tp,f(tp,xGN))
plot(tp,f(tp,xN))

subplot(1,2,2)
semilogy(res)
hold on
semilogy(res2)
