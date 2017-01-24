t=[0,.2,.4,.6,.8,1]';
b=[0,.451,.698,.834,.909,.950]';

f = @(t,a) a(1)*(1-exp(-a(2)*t));
df = @(t,a) [1-exp(-a(2)*t),a(1)*t.*exp(-a(2)*t)];

n=2;

F = @(x) (f(t,x)-b);
dF = @(x) df(t,x);
phi = @(x) 0.5*F(x)'*F(x);
dphi = @(x) (dF(x)')*F(x);

x0=[2,2]';

display('F(x0)');
F(x0)

display('dF(x0)')
dF(x0)

%% Gauss-Newton-Verfahren
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
xGN=x

figure
subplot(1,2,1)
tp=linspace(0,4,50);
plot(tp,f(tp,x0))
hold on
plot(t,b,'o')
plot(tp,f(tp,xGN))

subplot(1,2,2)
semilogy(res)
