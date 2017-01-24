f = @(x) [6*x(1)-2*x(2)-cos(x(1));8*x(2)-x(1)*x(2)^2-sin(x(1))];
A = @(x) [6+sin(x(1)), -2; -x(2)^2-cos(x(1)), 8-2*x(1)*x(2)];

x=[0,0]';
tol = 1e-15;
epsilonnewton=1;
maxIter=20;
iter=0;
xSolN=[x];
while epsilonnewton > tol && iter<maxIter
    [l,r,p]=lu(A(x));
    y=forward(l,p*f(x));
    s=backward(r,y);
    
    xneu=x-s;
    epsilonnewton=norm(x-xneu, 'inf');
    x = xneu;
    xSolN = [xSolN, x];
    iter = iter+1;
end
x

%% Konvergenzordnung
epsilonN = [];
for x = xSolN
    epsilonN = [epsilonN, norm(x-xSolN(:,end),'inf')];
end
x = epsilonN(1:end-3)';
y = epsilonN(2:end-2)';
A = [ones(length(x),1), log(x)];
[Q,R] = qr(A,0);
w=backward(R(1:2,:),Q'*log(y))

%% Graphik Output
figure
semilogy(epsilonN)
hold on
semilogy(epsilon1)
legend('Newton','Fixpunkt')
grid on

