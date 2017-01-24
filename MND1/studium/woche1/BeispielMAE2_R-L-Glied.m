%% Beispiel (3|4.10) aus dem MAE2 Skript,

U0=1;
R=2.5;
L=0.5;
omega=2*pi*2;

% didt = f(t,i)
f = @(t,i) -R/L*i+U0*sin(omega*t);

%% Analytische Loesungen
% mit Anfangsbedingung i(0) = 0
ip = @(t) U0/(R^2+omega^2*L^2)*(omega*L*exp(-R/L*t) + R*sin(omega*t) - omega*L*cos(omega*t));
% asymptotische Loesung
is = @(t) U0/(R^2+omega^2*L^2)*(R*sin(omega*t) - omega*L*cos(omega*t));

%% Richtungsfeld
t = linspace(0,2,40);
i = linspace(-0.5,0.5,40);

[ti, ii] = meshgrid(t,i);

vx = cos(atan(f(ti,ii)));
vy = sin(atan(f(ti,ii)));

quiver(ti,ii,vx,vy)
hold on

%% Loesungen im Richtungsfeld
t = linspace(0,2,400);
plot(t,ip(t))
plot(t,is(t))
