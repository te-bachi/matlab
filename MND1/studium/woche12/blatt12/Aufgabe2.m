clear all
clc

data=dlmread('../Aufgaben/dataAufgabe1.txt');

% Messungen
t=data(:,1);
b=data(:,2);

plot(t,b,'ro')

% Anzahl Messungen
m=length(b);

% Modell
f = @(t,x) (x(1)*sin(x(3)*t)+x(2)*cos(x(3)*t)).*exp(-x(4)*t)+x(5);
df = @(t,x) [...
    sin(x(3)*t).*exp(-x(4)*t),...
    cos(x(3)*t).*exp(-x(4)*t),...
    (x(1)*t.*cos(x(3)*t)-x(2)*t.*sin(x(3)*t)).*exp(-x(4)*t),...
    -t.*(x(1)*sin(x(3)*t)+x(2)*cos(x(3)*t)).*exp(-x(4)*t),...
    ones(length(t),1)];
% Anzahl Parameter
n=5;

% Abweichung Modell - Messwert
F = @(x) (f(t,x)-b);
dF = @(x) df(t,x);      % Jacobi-Matrix von F


% Summe der kleinesten Fehlerquadrate
% nichtlineare zu minimierende Funktion
phi = @(x) 0.5*F(x)'*F(x);  % (Potential = Summe der Fehlerquadrate)
dphi = @(x) (dF(x)')*F(x);  % Gradient von phi

% Initialwert fuer die Parameter
x0=[0.2,0.2,4*pi,0.1,0.25]';
tol=1e-12;
maxIter=40;

display('phi(x0)');
phi(x0)

display('dphi(x0)')
dphi(x0)

%% Levenberg-Marquardt-Verfahren
display('Levenberg-Marquardt-Verfahren');

x=x0;
tol=1e-12;
maxIter=200;
iter=0;
ok=true;
resLM=[];
mu=1;
beta0=0.2;
beta1=0.8;
while ok && (iter < maxIter)
    % lineares Ausgleichsproblem
    Fi = [F(x)',zeros(1,n)]';
    dFi = [dF(x)',mu*eye(n)]';
    
    [q,r] = qr(dFi);
    s = backward(r(1:n,:),-q(:,1:n)'*Fi);
    
    % Korrektur fuer die naechste Iteration
    xn = x+s;
    
    % Kontrolle
    rho = (norm(F(x))^2-norm(F(xn))^2)/(norm(F(x))^2-norm(F(x)+dF(x)*s)^2);
    if rho < beta0
        % Loesung wird nicht akzeptiert
        mu = mu * 2;    % mu vergroessern
    else
        % Loesung wird akzeptiert
        x = xn;
        if beta1 < rho
            mu = mu / 2; % mu verkleinern
        end
    end
    
    % Residuum ist durch die Norm des Gradienten von phi gegeben
    % dphi = 0 notwendige Bedingung fuer Minimum
    resLM = [resLM, norm(dphi(x),'inf')];
    if resLM(end) < tol
        ok=false;
    end
    iter = iter+1;
end
xLM=x;

display('phi(x0)');
phi(xLM)

display('dphi(x0)')
dphi(xLM)

%% Visualisierung
figure
subplot(1,2,1)
tp=linspace(0,5,250);

% plot(tp,f(tp,x0))   % Startparameter
hold on
plot(t,b,'o')
plot(tp,f(tp,xLM))

subplot(1,2,2)
semilogy(resLM)

xLM