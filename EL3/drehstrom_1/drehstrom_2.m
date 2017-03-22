
clear all;
close all;
clc;

%% Leistung P = U * I = U^2 / R
% u  = Scheitelwert
% w  = Kreizfrequenz [omega] (2*pi*f, const.)
% t  = Zeit
% ph = Nullphasenwinkel [phi] 
% R  = Widerstand
u = 10;
w = 2;
t = linspace(0,2);
R = 50;

P_f = @(u, w, t, ph, R) (u*cos(w*t + ph))^2/R;

%%
p1 = (u*cos(w*t + 0     )).^2/R;
p2 = (u*cos(w*t + 2*pi/3)).^2/R;
p3 = (u*cos(w*t - 2*pi/3)).^2/R;
p  = p1 + p2 + p3;

figure;
hold on;

plot(t, p1, 'r');
plot(t, p2, 'g');
plot(t, p3, 'b');
plot(t, p1+p2, 'y');
legend('P_1(t)', 'P_2(t)', 'P_3(t)', 'P_1(t) + P_2(t)');
hold off;

