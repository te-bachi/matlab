
clear all;
close all;
clc;

u_stern         = 230;
u_drei          = 400;
w               = 2*pi*50;
t               = linspace(0,0.05);

u1_stern_phi0   = 0;
u2_stern_phi0   = -2*pi/3;
u3_stern_phi0   = 2*pi/3;

u1_phi  = w * t + u1_stern_phi0;
u2_phi  = w * t + u2_stern_phi0;
u3_phi  = w * t + u3_stern_phi0;

%%
u1_t    = u_stern * cos(u1_phi);
u2_t    = u_stern * cos(u2_phi);
u3_t    = u_stern * cos(u3_phi);

%%
u1n     = u_stern * exp(1i * u1_stern_phi0);
u2n     = u_stern * exp(1i * u2_stern_phi0);
u3n     = u_stern * exp(1i * u3_stern_phi0);

%%
u12     = u1n - u2n;
u23     = u2n - u3n;
u31     = u3n - u1n;

%%
figure;
hold on;

plot(t, u1_t, 'r');
plot(t, u2_t, 'g');
plot(t, u3_t, 'b');
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');

hold off;

%%
figure;
hold on;
grid on;
grid minor;
    
axis([-400 400 -400 400]);
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');
plot([0 real(u1n)], [0 imag(u1n)], 'Color', 'red',   'LineWidth', 1.5);
plot([0 real(u12)], [0 imag(u12)], 'Color', 'red',   'LineStyle', '--', 'LineWidth', 1.5);
plot([0 real(u2n)], [0 imag(u2n)], 'Color', 'green', 'LineWidth', 1.5);
plot([0 real(u23)], [0 imag(u23)], 'Color', 'green', 'LineStyle', '--', 'LineWidth', 1.5);
plot([0 real(u3n)], [0 imag(u3n)], 'Color', 'blue',  'LineWidth', 1.5);
plot([0 real(u31)], [0 imag(u31)], 'Color', 'blue',  'LineStyle', '--', 'LineWidth', 1.5);
daspect([1 1 1]);
hold off;

