function [t, y] = explicitRunge(f, dt, Tend, y0)
    n       = round(Tend / dt);
    t       = zeros(n + 1, 1);
    y       = zeros(n + 1, length(y0));
    y(1,:)  = y0;
    for i = 1:n
        r1          = f(t(i), y(i,:));
        r2          = f(t(i) + dt/2,  y(i,:) + dt/2 * r1);
        y(i + 1, :) = y(i,:) + dt * r2;
        t(i + 1)    = t(i) + dt;
    end
end