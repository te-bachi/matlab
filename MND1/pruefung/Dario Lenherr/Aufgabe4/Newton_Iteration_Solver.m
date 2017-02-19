%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEWTON VERFAHREN            %
% James Kiwic HS16 MND1       %
% v1                28.12.2016%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xn l] = Newton_Iteration_Solver(f, df, max_it, tol, x0, lambda)

% Parameter für iteration
l = 0;
if(lambda == 0)
   lambda = 1; 
end

%start wert
xn = x0;

% norm als vorbereitung für vektorielle rechnung
while (norm(f(xn)) > tol && l < max_it)
    
    % für vektorielle rechnung Anpassen
    s = LR_Solver(df(xn),f(xn));
    xn = xn - lambda*s;
    
    l = l + 1;
end
l
if(l >= max_it)
    disp('newton did not converge');
end

