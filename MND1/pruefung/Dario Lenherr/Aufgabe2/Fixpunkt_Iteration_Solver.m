%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIXPUNKT ITERATION          %
% James Kiwic HS16 MND1       %
% v1                28.12.2016%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xn l]= Fixpunkt_Iteration_Solver(f,max_it,tol,x0)

% Parameter
%max_it = 100;   % max anzahl Iterationen
%tol = 1e-8;     % min toleranz

% Startwert
%x0 = 0;         % (kann auch vektorwertig sein)

% Fixpunktfunktion der form f(x) = cos(x) = x
%f = @(x) [cos(x)];   % Vektorwertige Funktion (kann auch vektorwertig sein)


%iteration
l = 0;
xn = f(x0);     % erster Funktionswert berechnen
while (norm(xn - f(xn)) > tol) && (l < max_it)
    
    xn = f(xn); % neuer x-Wert berechnen
    
    l = 1 + l;  % Zähler incrementieren
end

