clear all,close all,clc
%Man muss die Gleichung fx=0 auflösen
f=@(x1,x2) [(x1-1)^2+8*(x2-1/2)^2-3; (x1-1/2)^4+(x2-1/2)^4-1];
df=@(x1,x2) [2*(x1-1) 8*(2*x2-1); ((2*x1-1)^3)/2 ((2*x2-1)^3)/2];

%% Newton-Verfahren
iter=0;
maxIter=200;
x0=[-0.5;0.8];
tol=1e-14;
res=1;
xalt=x0;
solN=[x0];
while (res > tol) && (iter < maxIter)
    A=df(xalt(1),xalt(2));
    b=f(xalt(1),xalt(2));
    [L,R,P] = lu(A);
    y = forward(L,P*b);
    s = backward(R,y);
    
    % Newton-Iteration
    xneu = xalt - s;
    
    % Residuum f(xneu)
    res=norm(f(xalt(1),xalt(2)),'inf');
    
    % speichern der Loesung
    xalt = xneu;
    solN = [solN, xneu];
    iter = iter+1;
end
display('Die Iteration vom Newtonverfahren ist = ')
iter
xneu


%% vereinfachtes Newton-Verfahren
iter=0;
maxIter=200;
x0=[2;2];
tol=1e-12;
res=1;
xalt=x0;

solVN=[x0];

A=df(xalt(1),xalt(2));
[L,R,P] = lu(A);

while (res > tol) && (iter < maxIter)
    b=f(xalt(1),xalt(2));
    y = forward(L,P*b);
    s = backward(R,y);
    
    % Newton-Iteration
    xneu = xalt - s;
    
    % Residuum f(xneu)
    res=norm(f(xalt(1),xalt(2)),'inf');
    
    % speichern der Loesung
    xalt = xneu;
    solVN = [solVN, xneu];
    iter = iter+1;
end
display('Die Iteration vom vereinfachtem Newtonverfahren ist = ')
iter
xneu

%% Konvergenz-Vergleich

deltaN=[];
for x=solN
    deltaN = [deltaN, norm(x-solN(:,end),'inf')];
end
deltaVN=[];
for x=solVN
    deltaVN = [deltaVN, norm(x-solVN(:,end),'inf')];
end

semilogy(deltaN)
hold on
semilogy(deltaVN)
legend('Newton-Verfahren','Vereinfachtes Newton-Verfahren')
