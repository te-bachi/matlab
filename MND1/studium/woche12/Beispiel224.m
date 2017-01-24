ti=[0.1,0.3,0.7,1.2,1.6,2.2,2.7,3.1,3.5,3.9]';
ui=[0.558,0.569,0.176,-0.207,-0.133,0.132,0.055,-0.090,-0.069,0.027]';

f = @(t,x) x(1)*exp(-x(2)*t).*sin(x(3)*t+x(4));
df = @(t,x) [exp(-x(2)*t).*sin(x(3)*t+x(4)), -t*x(1).*exp(-x(2)*t).*sin(x(3)*t+x(4)), x(1)*exp(-x(2)*t).*t.*cos(x(3)*t+x(4)), x(1)*exp(-x(2)*t).*cos(x(3)*t+x(4))];

n=4;

F = @(x) (f(ti,x)-ui);
dF = @(x) df(ti,x);
phi = @(x) 0.5*F(x)'*F(x);
dphi = @(x) (dF(x)')*F(x);
d2phi = @(x) (dF(x)'*dF(x)+d2phiBeispiel222(ti,x,ui));

x0=[1,2,2,1]';
tol=1e-10;
maxIter=200;

display('F(x0)');
F(x0)

display('dF(x0)')
dF(x0)

%% Gauss-Newton-Verfahren
x=x0;
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

%% Newton-Verfahren
x0=[1,1,3,1]';

lambdamin=1e-8;
x=x0;
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
    % einfaches ged?mpftes Verfahren phi soll minimiert werden:
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

%% Levenberg-Marquardt Verfahren
ok=true;

x=x0;
iter = 0;

% Levenberg-Marquardt Verfahren
% (mit mu=0 folgt das Gauss-Newton Verfahren)
mu=1;
mumax = 1e3;
mumin = 0;
beta0=0.2;
beta1=0.8;

mus=[mu];
phis = [];
rhos = [];
si = [];
gradphis = [];
res3=[];

while ok && (iter < maxIter)
    % erweiterte  Jacobi-Matrix
    A = [dF(x); mu*eye(n)];
    [q,r] = qr(A);
    % erweiterte rechte Seite
    b = [F(x); zeros(n,1)];
    % Loesen des Systems durch Rueckwaertseinsetzen
    s=backward(r(1:n,:),-q(:,1:n)'*b);
    % neues x
    xn = x+s;
    
    rho = (norm(F(x))^2-norm(F(xn))^2)/(norm(F(x))^2-norm(F(x)+dF(x)*s)^2);
    
    if(rho>beta1)
        if (mu > mumin) % Fall rho > beta1
            mu = mu/2;  % mu wird verkleinert
        end
        x=xn;           % Loesung wird verwendet
    else if(rho>beta0)  % beta0 < rho < beta1
            x = xn;     % mu bleibt unveraendert, Loesung wird verwendet
        else            % mu < beta0
            if(mu < mumax)
                mu = mu*2; % mu wird vergroessert, Loesung wird nicht verwendet
            end
        end
    end
    
    iter = iter +1;
    % Abbruchkriterium: norm(grad phi) < tol
    % und Schrittweite soll gen?gend gross sein: 
    % norm(s) < 1e-16
    res3 = [res3, norm(dphi(x),'inf')];
    si = [si, norm(s,'inf')]; 
    if((res3(end) < tol) || (si(end) < 1e-18))
        ok = false;
    end
    
    mus = [mus, mu];
    rhos = [rhos, rho];
    phis = [phis, phi(x)];
    %ok=false;
end
xLM=x



figure
subplot(1,2,1)
tp=linspace(0,4,250);
plot(tp,f(tp,x0),'--')
hold on
plot(ti,ui,'o')
plot(tp,f(tp,xGN))
plot(tp,f(tp,xN))
plot(tp,f(tp,xLM))

subplot(1,2,2)
semilogy(res)
hold on
semilogy(res2)
semilogy(res3)
