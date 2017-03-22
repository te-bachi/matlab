
clear all;
close all;
clc;

%% MEST 4, Uebung 1, Harm. Osz
% Bachmann Andreas, 01.03.2017
% [CTRL] + Enter = Teil ausführen

%% A1, gedämpfter HO
% a)
m = 1;
c = 10;
d = 0.5;

% b)
A = [
    0,      1;
    -c/m,   -d/m;
];

% e)
f1 = @(t, x) A * x;


%% A1 Lösung
% a)
sim('ueb1_A1_ver4');

set(groot, 'defaultAxesTickLabelInterpreter',   'latex');
set(groot, 'defaultLegendInterpreter',          'latex');
set(groot, 'defaultTextInterpreter',            'latex');
plot(sim_x.time, sim_x.signals.values)
grid;
grid minor;
xlabel('Zeit / sec.');
ylabel('HO Pos. / m');

% e)

%              func, t,    x
[t, y] = ode45(f1, [0:0.05:10], [0; 2]);
subplot(211);
plot(t, y(:,1));
grid on;
grid minor;
legend('Position');

subplot(212);
plot(t, y(:,2));
grid on;
grid minor;
legend('Velocity');

%% A2, 


%% A3, 
