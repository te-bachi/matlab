
function x=lr_backward(R,b)
    n    = length(R);      % Wieviele Xi gibt es => n
    x    = zeros(n, 1);    % Alle Xi auf Null setzen
    x(n) = b(n) / R(n,n);  % Die letzte Gleichung (n) lösen
    
    % Die zwei-letzte bis zur ersten Gleichung lösen
    % Laufvariable      k = n-1
    % Schrittweite:     -1
    % Abbruchbedingung: k < 1
    for k=n-1:-1:1
        x(k) = (b(k) - R(k, ((k+1):n)) * x((k+1):n)) / R(k,k);
    end
end