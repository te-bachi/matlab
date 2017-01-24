%% Messdaten
t=[0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]';
u=[0., 0.121, 0.285, 0.139, -0.352, -0.75, -0.529, 0.324, 1.141, 1.092, 0]';

%% 1. Ansatz
% f = @(t,a) a(1)*exp(a(2)*t).*sin(2*pi*a(3)*t);
% df = @(t,a) [exp(a(2)*t).*sin(2*pi*a(3)*t),...
%    a(1)*exp(a(2)*t).*t.*sin(2*pi*a(3)*t),...
%    a(1)*exp(a(2)*t).*cos(2*pi*a(3)*t)*2*pi.*t];
% n=3; % Anzahl Parameter
% x0=[.5,1,1.5]'; % Startparameter


%% 2. Ansatz
f = @(t,a) a(1)*t.*sin(2*pi*a(2)*t);
df = @(t,a) [t.*sin(2*pi*a(2)*t),a(1)*t.*cos(2*pi*a(2)*t)*2*pi.*t];
n=2; % Anzahl Parameter
x0=[2,1.5]'; % Startparameter

F = @(x) (f(t,x)-u);
dF = @(x) df(t,x);
phi = @(x) 0.5*F(x)'*F(x);
dphi = @(x) (dF(x)')*F(x);


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
tp=linspace(0,max(t),50);
plot(tp,f(tp,x0))
hold on
plot(t,u,'o')
plot(tp,f(tp,xGN))

subplot(1,2,2)
semilogy(res)
