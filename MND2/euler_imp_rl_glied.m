
clear all;
close all;
clc;

u0      = 1;        % Volt
f       = 2;        % Hertz
w       = 2*pi*f;   % 1/s
R       = 2.5;      % Ohm
L       = 10e-3;    % mH, Mili-Henry

u       = @(t) u0 * sin(w * t);

i0      = 0;
t0      = 0;
dt      = 0.001;    % dt = 0.01 geht nicht
tend    = 2;

k       = 1;
i       = [ i0 ];
t       = [ t0 ];

while t(k) < tend
    t(k + 1)    = t(k) + dt;
    i(k + 1)    = 1/(1 + R/L * dt) * (i(k) + dt/L * u(t(k + 1)));
    k           = k + 1;
end

plot(t, i);


