maxIter = 200;
tol=1e-15;
L=1/2;

F = @(x) [1/6*cos(x(1))+1/3*x(2);
       1/8*x(1)*x(2)^2+1/8*sin(x(1))];

x0=[0,0]';

% Anzahl Schritte nach a priori Fehlersch?tzung
fprintf('\nMaximale Anzahl Schritt nach a priori Fehlerschaetzung fuer den Startwert:')
n0 = log(tol/norm(F(x0)-x0,'inf')*(1-L))/log(L)

ok=true;
iter=0;
sol1=[x0];
epsilon1=[];
posteriori=[];
while (ok && iter < maxIter)
    % berechnen Fixpunkt-Folge
    u = F(sol1(:,end));
    
    % ||x_{n+1}-x_n||_infty
    epsilon=norm(sol1(:,end)-u,'inf');
    if(epsilon < tol)
        ok=false;
    end
    % speichern von ||x_{n+1}-x_n||_infty
    epsilon1 = [epsilon1, epsilon];
    posteriori = [posteriori,L/(1-L)*norm(epsilon,'inf')]; 
    % und Loesung
    sol1=[sol1, u];
    % Anzahl Iterationsschritte
    iter = iter+1;
end

sol1(:,end)

%% Graphik Output
semilogy(epsilon1)
hold on
semilogy(L.^(1:12)/(1-L)*norm(sol1(:,1)-sol1(:,2),'inf'))
semilogy(posteriori,'--')
legend('xn','a priori', 'a posteriori')
grid on

% Konvergenzordnung
epsilon=[];
for x = sol1
    epsilon = [epsilon, norm(x-sol1(:,end),'inf')];
end

semilogy(epsilon)

% lineare Regression der Fehlerordnung
y = log(epsilon(2:end-1))';
x = log(epsilon(1:end-2))';

A = [ones(length(y),1), x]
[Q,R] = qr(A);
x = backward(R(1:2,:),Q'*y)

