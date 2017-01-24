%% Beispiel 2.20: Nichtlineare Integral Gleichung 
maxIter = 200;  % maximale Anzahl Iterationen
tol=1e-14;       % gewuenschte Toleranz

n=200;          % Anzahl Stuetzstellen
x=1/n*(1:n)';   % Koordinaten der Stuetzstellen
u0=ones(n,1);   % Startwert
%u0=zeros(n,1);   % Startwert
%u0=-4.5*sin(4*pi*x);

%% Fixpunkt Iteration fuer p=2
ok=true;
iter=0;
ualt=u0;
epsilonFix=[];
while (ok && iter < maxIter)
    uFix = nonlinIntegralEQFixPkt(x,ualt,2);
    epsilon=norm(ualt-uFix,'inf');
    if(epsilon < tol)
        ok=false;
    end
    epsilonFix = [epsilonFix, epsilon];
    ualt=uFix;
    iter = iter+1;
end
display(iter)

%% Newton Iteration fuer p=2
ok=true;
iter=0;
ualt=u0;
epsilonNewton=[];
while (ok && iter < maxIter)
    [l,r]=lu(nonlinIntegralEQNewtonJacobi(x,ualt,2));
    y=forward(l,nonlinIntegralEQNewton(x,ualt,2));
    s=backward(r,y);
    
    uNewton = ualt - s;
    epsilon=norm(ualt-uNewton,'inf');
    if(epsilon < tol)
        ok=false;
    end
    epsilonNewton = [epsilonNewton, epsilon];
    ualt=uNewton;
    iter = iter+1;
end
display(iter)

%% vereinfachte Newton Iteration fuer p=2
ok=true;
iter=0;
ualt=u0;
epsilonNewtonV=[];
[l,r]=lu(nonlinIntegralEQNewtonJacobi(x,ualt,2));
while (ok && iter < maxIter)
    y=forward(l,nonlinIntegralEQNewton(x,ualt,2));
    s=backward(r,y);
    
    uNewtonV = ualt - s;
    epsilon=norm(ualt-uNewton,'inf');
    if(epsilon < tol)
        ok=false;
    end
    epsilonNewtonV = [epsilonNewtonV, epsilon];
    ualt=uNewtonV;
    iter = iter+1;
end
display(iter)

%% Graphik Output
figure
subplot(1,2,1)
plot(x,uNewton)
hold on
plot(x,uFix,'--')
plot(x,uNewtonV,'-.')
title('Loesung der Integralgleichung')
legend('p=2, Newton Verfahren','p=2, Fixpunktiteration','p=2, vereinf. Newton Verf.','Location','southeast')
axis square

subplot(1,2,2)
semilogy(epsilonNewton)
hold on
semilogy(epsilonFix)
semilogy(epsilonNewtonV)
title('Konvervenz')
legend('p=2, Newton Verfahren','p=2, Fixpunktiteration','p=2, vereinf. Newton Verf.','Location','southeast')
axis square
