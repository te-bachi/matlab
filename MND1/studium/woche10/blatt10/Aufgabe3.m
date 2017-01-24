f=@(x1,x2) [3*x1^2-x2^2; 3*x1*x2^2-x1^3-1];
df=@(x1,x2) [6*x1, -2*x2; 3*x2^2-3*x1^2, 6*x1*x2];

%% Newton-Verfahren
iter=0;
maxIter=200;
x0=[1;1];
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

xneu


%% vereinfachtes Newton-Verfahren
iter=0;
maxIter=200;
x0=[1;1];
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
