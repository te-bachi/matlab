
clear all;
close all;
clc;

%%
% u  = Scheitelwert
% w  = Kreizfrequenz [omega] (2*pi*f, const.)
% t  = Zeit
% ph = Nullphasenwinkel [phi] 
% R  = Widerstand
u = 230;
w = 2*pi*50;
t = linspace(0,0.05);

%%
u1 = (u*cos(w*t + 0     ));
u2 = (u*cos(w*t - 2*pi/3));
u3 = (u*cos(w*t + 2*pi/3));

figure;
hold on;

plot(t, u1, 'r');
plot(t, u2, 'g');
plot(t, u3, 'b');
plot(t, u1+u2, 'y');
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');
legend('U_1(t)', 'U_2(t)', 'U_3(t)', 'U_1(t) + U_2(t)');
hold off;

