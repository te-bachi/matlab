clc, clear, close all

%% Projekt 2: nicht lin. Ausgleichsrechnung

%% Vorausgehende Berechnungen
% syms x x0 sigma a b
% sf = exp(-(x-x0)^2/sigma)*(a*(x-x0)^3+b*(x-x0));
% dsf = diff(sf,x0);
% dsfs = diff(sf,sigma);
% dsfa = diff(sf,a);
% dsfb = diff(sf,b);


% 16 Messungen durchgeführt liefert:
xi = [-11:2:19]';    %in mm
x0=[3,1,1,1]';   %in mm


%Messvektor b
bi =[-0.45,-1.86,4.93,-9.02,-10.91,-8.25,-3.47,-0.29,4.25,8.98,10.90,8.36,4.28,1.51,0.38,0.007]';

y = @(d,x) exp(-(d - x(1)).^2/x(2)).*(x(3)*(d - x(1)).^3+x(4)*(d - x(1)));

% Fehlerfunktion F
%x(1) = x0
%x(2) = sigma 
%x(3) = a
%x(4) = b
F = @(x) y(xi,x)-bi;
dF = @(x) [(exp(-(xi - x(1)).^2/x(2)).*(2*xi - 2*x(1)).*(x(4).*(xi - x(1)) + x(3).*(xi - x(1)).^3))/x(2) - exp(-(xi - x(1)).^2/x(2)).*(x(4) + 3*x(3)*(xi - x(1)).^2),(exp(-(xi - x(1)).^2/x(2)).*(x(4).*(xi - x(1)) + x(3).*(xi - x(1)).^3).*(xi - x(1)).^2)/(x(2)^2),exp(-(xi - x(1)).^2/x(2)).*(xi - x(1)).^3,exp(-(xi - x(1)).^2/x(2)).*(xi - x(1))];

tol = 1e-12;
maxIter = 200;
iter = 0;
x = x0;

%Newton gedämpft
mu = 1;
mumax = 1e5;
mumin = 1e-5;
beta0 = 0.2;
beta1 = 0.8;

mus=[mu];
phis = [];
si = [];
gradphis = [];
ok = true;
while(ok && iter<maxIter)
    A = [dF(x)',mu*eye(4)]';
    b = [F(x)',zeros(1,4)]';
    [Q,R] = qr(A,0);
    s = chol_backward(R,Q'*-b);
    xn = x + s;
    rho = (norm(F(x))^2-norm(F(xn))^2)/(norm(F(x))^2-norm(F(x)+dF(x)*s)^2);
    iter = iter + 1;
    
    if(rho>beta1)
        if(mu > mumin)
            mu = mu/2;
        end
        x = xn;
    else if(rho>beta0)
        x = xn;
        else
            if(mu < mumax)
                mu = mu*2;
            end
        end
    end
    % Abbruchkriterium: norm(grad phi) < tol
    % und Schrittweite soll gen?gend gross sein: 
    % norm(s) < 1e-16
    gradphis = [gradphis, norm(dF(x)'*F(x),'inf')];
    si = [si, norm(s,'inf')]; 
    if((gradphis(end) < tol) || (si(end) < 1e-18))
        ok = false;
    end
    
    mus = [mus, mu];
    phis = [phis, 0.5*F(x)'*F(x)];
end

hold on
plot(xi,bi,'.');
xplot = linspace(-15,20,120);
plot(xplot,y(xplot,x))
grid
hold off
