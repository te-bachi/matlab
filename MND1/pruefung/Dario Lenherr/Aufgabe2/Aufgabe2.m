clear all, clc, clf;

f=@(x,y,z) [(1/8).*exp(-x.^2-y.^2-z.^2);(1/3).*sin(x).*cos(y);1./(2.*(z+1))];

max_it = 5;   % max anzahl Iterationen
tol = 1e-8;     % min toleranz

% Startwert
x0 = [0.5;0.5;0.5];         % (kann auch vektorwertig sein)

% Fixpunktfunktion der form f(x) = cos(x) = x


Fixpunkt_Iteration_Solver(f, max_it, tol, x0)