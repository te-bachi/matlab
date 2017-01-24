%% Anwendung Fixpunkt-Iteration
%  Loesen von linearen Gleichungssysteme

clear all;

%% Berechnen der Matrix A und rechte Seite b
% fuer die Integralgleichung

n=400;          % Anzahl Stuetzstellen
A=eye(n);       % Identitaet
x=1/n*(1:n)';   % Koordinaten der Stuetzstellen

A=A+1/n*cos(4*pi*x*x').^2; % diskrete Integralgleichung

b=ones(n,1);    % rechte Seite

%% Loesung mit Cholesky-Zerlegung
% A ist symmetrisch positiv definit
% das System kann daher mit der Cholesky-Zerlegung
% geloest werden
L = chol(A)';
y = forward(L,b);
uchol = backward(L',y);

%% Loesung mit Jacobi-Verfahren
%
% hier Jacobi-Verfahren programmieren
%
% D,L,R berechnen

maxIter = 100;  % maximale Anzahl Iterationen
tol=1e-14;      % gewuenschte Toleranz

u0=ones(n,1);   % Startwert

ok=true;
iter=0;
ualt=u0;        % Loesung des letzten Iterationsschrittes
epsilon1=[];

while (ok && iter < maxIter)
    % Jacobi - Iteration fuer lineare Gleichungssysteme

    
    % Norm der Differenz
    epsilon=norm(ualt-u,'inf');
    if(epsilon < tol)
        ok=false;
    end
    % wird gespeichert um die Konvergenzordnung darzustellen
    epsilon1 = [epsilon1, epsilon];
    % speichern der aktuellen Loesung
    ualt = u;
    iter = iter+1;
end


%% Graphik Output
figure
subplot(1,2,1)
plot(x,u)
hold on
plot(x,uchol)
title('Loesung der Integralgleichung')
legend('Jacobi Loesung','Cholesky Loesung','Location','southeast')
axis square

subplot(1,2,2)
semilogy(epsilon1)
title('Konvervenz Jacobi-Verfahren')
axis square
