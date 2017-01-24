f=@(x,y) [x^2-y-1; (x-2)^2+(y-0.5)^2-1];
df=@(x,y) [2*x, -1; 2*(x-2), 2*(y-0.5)];

%% Newton-Verfahren
iter=0;
maxIter=200;
x0=[1.5;1.5];   % Startwerte fuer den zweiten Punkt
% x0=[1;0];       % Startwerte fuer den ersten Punkt
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


