
clear all;
close all;
clc;

%% Leistung P = U * I = U^2 / R
% u  = Scheitelwert
% w  = Kreizfrequenz [omega] (2*pi*f, const.)
% t  = Zeit
% ph = Nullphasenwinkel [phi] 
% R  = Widerstand
syms t u w R;
P1_f = @(u, w, t, ph, R) (u*cos(w*t + ph))^2/R;

%%
P1 = (u*cos(w*t + 0     ))^2/R;
P2 = (u*cos(w*t + 2*pi/3))^2/R;
P3 = (u*cos(w*t - 2*pi/3))^2/R;
P  = P1 + P2 + P3;
simplify(P)

p1 = subs(P1, [u w R], [10 2 50]);
p2 = subs(P2, [u w R], [10 2 50]);
p3 = subs(P3, [u w R], [10 2 50]);
fplot(p1, 'r');
hold on;
fplot(p2, 'g');
fplot(p3, 'b');
fplot(p1+p2+p3, 'y');
axis([0 5 0 3.5]);
legend('P_1(t)', 'P_2(t)', 'P_3(t)', 'P(t)');
hold off;

