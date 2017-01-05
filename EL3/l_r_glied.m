
clear, clc

omega    = 2*pi*2;
U0       = 1;
R        = 2.5;
L        = 0.5;
f        = @(t,i) -R/L*i+U0*sin(omega*t);

%t     = (0:0.2:2);
%i     = (-0.5:0.1:0.5);
t        = linspace(0,2,40);
i        = linspace(-0.5,0.5,40);

[ti, ii] = meshgrid(t,i);

vx       = cos(atan(f(ti,ii)));
vy       = sin(atan(f(ti,ii)));

quiver(ti,ii,vx,vy);

ip = @(t) U0/(


