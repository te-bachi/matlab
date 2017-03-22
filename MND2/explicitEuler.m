function [t, y] = explicitEuler(f, dt, Tend, y0)
    n       = round(Tend / dt);
    t       = zeros(n + 1, 1);
    y       = zeros(n + 1, length(y0));
    y(1,:)  = y0;
    for i = 1:n
        y(i + 1, :) = y(i,:) + dt * f(t(i), y(i,:));
        t(i + 1)    = t(i) + dt;
    end
end