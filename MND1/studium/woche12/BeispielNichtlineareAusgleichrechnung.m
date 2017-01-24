t=[0, 1, 2, 3]';
b=[0., 0.63, 0.86, 0.95]';

% Modell
f = @(t,x) x(1)*(1-exp(-x(2)*t));
df = @(t,x) [(1-exp(-x(2)*t)), x(1)*t.*exp(-x(2)*t)];

% Anzahl Parameter
n=2;

% Abweichung Modell - Messwert
F = @(x) (f(t,x)-b);
dF = @(x) df(t,x);      % Jacobi-Matrix von F


% Summe der kleinesten Fehlerquadrate
% nichtlineare zu minimierende Funktion
phi = @(x) 0.5*F(x)'*F(x);  % (Potential = Summe der Fehlerquadrate)
dphi = @(x) (dF(x)')*F(x);  % Gradient von phi

% Initialwert fuer die Parameter
x0=[2,2]';

display('phi(x0)');
phi(x0)

display('dphi(x0)')
dphi(x0)

%% Gauss-Newton-Verfahren
x=x0;
tol=1e-10;
maxIter=200;
iter=0;
ok=true;
res=[];
while ok && (iter < maxIter)
    % lineares Ausgleichsproblem
    Fi = F(x);
    dFi = dF(x);
    
    [q,r] = qr(dFi);
    s = backward(r(1:n,:),-q(:,1:n)'*Fi);
    
    % Korrektur fuer die naechste Iteration
    x = x+s;
    % Residuum ist durch die Norm des Gradienten von phi gegeben
    % dphi = 0 notwendige Bedingung fuer Minimum
    res = [res, norm(dphi(x),'inf')];
    if res(end) < tol
        ok=false;
    end
    iter = iter+1;
end
xGN=x;

display('phi(x0)');
phi(xGN)

display('dphi(x0)')
dphi(xGN)


figure
subplot(1,2,1)
tp=linspace(0,4,50);
% plot(tp,f(tp,x0))   % Startparameter
hold on
plot(t,b,'o')
plot(tp,f(tp,xGN))

subplot(1,2,2)
semilogy(res)

xGN