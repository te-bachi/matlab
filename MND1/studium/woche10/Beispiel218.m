%% Beispiel 2.18: Nichtlineare Integral Gleichung 
maxIter = 200;  % maximale Anzahl Iterationen
tol=1e-8;       % gewuenschte Toleranz

n=200;          % Anzahl Stuetzstellen
x=1/n*(1:n)';   % Koordinaten der Stuetzstellen
u0=ones(n,1);   % Startwert

%% Lineares System fuer p=1
A=eye(n)+1/n*cos(4*pi*x*x').^2;  % diskrete Integralgleichung
b=ones(n,1);                % rechte Seite

%% Loesung mit Jacobi-Verfahren
% D,L,U berechnen
D=diag(diag(A));
Dinv=diag(1./diag(A));
L=-tril(A,-1);
U=-triu(A,1);

ok=true;
iter=0;
ualt=u0;        % Loesung des letzten Iterationsschrittes
epsilon1Jac=[];

while (ok && iter < maxIter)
    % Jacobi - Iteration fuer lineare Gleichungssysteme
    ujac = Dinv*((L+U)*ualt+b);
    
    % Norm der Differenz
    epsilon=norm(ualt-ujac,'inf');
    if(epsilon < tol)
        ok=false;
    end
    % wird gespeichert um die Konvergenzordnung darzustellen
    epsilon1Jac = [epsilon1Jac, epsilon];
    % speichern der aktuellen Loesung
    ualt = ujac;
    iter = iter+1;
end

%% Fixpunkt Iteration fuer p=1
ok=true;
iter=0;
sol1=[u0];
epsilon1=[];
while (ok && iter < maxIter)
    u = nonlinIntegralEQFixPkt(x,sol1(:,end),1);
    epsilon=norm(sol1(:,end)-u,'inf');
    if(epsilon < tol)
        ok=false;
    end
    epsilon1 = [epsilon1, epsilon];
    sol1=[sol1, u];
    iter = iter+1;
end

%% Fixpunkt Iteration fuer p=2
u0=ujac;   % Startwert
ok=true;
iter=0;
sol2=[u0];
epsilon2=[];
while (ok && iter < maxIter)
    u = nonlinIntegralEQFixPkt(x,sol2(:,end),2);
    epsilon=norm(sol2(:,end)-u,'inf');
    if(epsilon < tol)
        ok=false;
    end
    epsilon2 = [epsilon2, epsilon];
    sol2=[sol2, u];
    iter = iter+1;
end

%% Fixpunkt Iteration fuer p=3
ok=true;
iter=0;
sol3=[u0];
epsilon3=[];
while (ok && iter < maxIter)
    u = nonlinIntegralEQFixPkt(x,sol3(:,end),3);
    epsilon=norm(sol3(:,end)-u,'inf');
    if(epsilon < tol)
        ok=false;
    end
    epsilon3 = [epsilon3, epsilon];
    sol3=[sol3, u];
    iter = iter+1;
end

%% Fixpunkt Iteration fuer p=8
ok=true;
iter=0;
sol8=[u0];
epsilon8=[];
while (ok && iter < maxIter)
    u = nonlinIntegralEQFixPkt(x,sol8(:,end),8);
    epsilon=norm(sol8(:,end)-u,'inf');
    if(epsilon < tol)
        ok=false;
    end
    epsilon8 = [epsilon8, epsilon];
    sol8=[sol8, u];
    iter = iter+1;
end

%% Graphik Output
fig=figure
subplot(1,2,1)
plot(x,sol1(:,end))
hold on
plot(x,ujac,'--')
plot(x,sol2(:,end))
plot(x,sol3(:,end))
plot(x,sol8(:,end))
title('Loesung der Integralgleichung')
legend('p=1','p=1, Jac-Iter','p=2','p=3','p=8','Location','southeast')
axis square

subplot(1,2,2)
semilogy(epsilon1)
hold on
semilogy(epsilon1Jac)
semilogy(epsilon2)
semilogy(epsilon3)
semilogy(epsilon8)
title('Konvervenz')
legend('p=1','p=1, Jac-Iter','p=2','p=3','p=8')
axis square

