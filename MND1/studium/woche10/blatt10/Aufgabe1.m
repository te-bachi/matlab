f=@(x1,x2) [0.5*log(1+x2);0.25*(1+sin(x1)*cos(x2))];

iter=0;
maxIter=100;
x0=[0;0];
tol=1e-12;
error=1;
xalt=x0;
while (error > tol) && (iter < maxIter)
    % Fixpunkt-Iteration
    xneu = f(xalt(1),xalt(2));
    
    % Norm der Differenz
    error=norm(xalt-xneu,'inf');
    
    % speichern der Loesung
    xalt = xneu
    iter = iter+1;
end

xneu

