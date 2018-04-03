function [y] = Mfunc(lambda, T)


    h  = 6.6262e-34; % J*s
    kb = 1.3807e-23; % J/K
    c  = 3e8;        % m/s
    
    a = 2 * h * c^2;
    b = lambda.^5;
    e = exp((h*c)./(lambda .* kb * T));
    y = (a ./ b) .* (1 ./ (e - 1));
end

