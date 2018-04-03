
%%
clear all;
close all;
clc;


set(groot, 'defaultAxesTickLabelInterpreter',   'latex');
set(groot, 'defaultLegendInterpreter',          'latex');
set(groot, 'defaultTextInterpreter',            'latex');

%%

h  = 6.6262e-34; % J*s
kb = 1.3807e-23; % J/K
c  = 3e8;        % m/s

%M = @(lambda, T) ((2.*h.*c.^2)./(lambda.^5)).*(1./exp((h*c)./(lambda.*kb*T)) - 1);
%N = @(lambda) ((2.*h.*c.^2)./(lambda.^5)).*(1./exp((h*c)./(lambda.*kb* 273.15)) - 1);

lambda = linspace(1*10^-9, 25e-6, 1000);
%lambda = linspace(0, 25e-6);
%a = 800*10^-9:5e-6:25e-6;
Tmax  = 40;
Tmin  = 10;
Tstep = 10;

y          = zeros(Tmax / Tmin + 2, length(lambda));
T          = Tmin;
for i = 1:(Tmax / Tmin)
    y(i,:)          = bachman0_Mfunc(lambda, T + 273.15);
    T               = Tmin + i * Tstep;
end

y(Tmax / Tmin + 1,:)          = bachman0_Mfunc(lambda, 0.00001);
y(Tmax / Tmin + 2,:)          = bachman0_Mfunc(lambda, 1000000);

%% 1
figure;
plot(lambda, y(1:4,:), 'LineWidth', 1.5);

grid on;
grid minor;
xlabel('Wavelength $\lambda$ [$\mu$m]');
ylabel('Spectral radiance');
legend('$10\,^{\circ}\mathrm{C}$', ...
       '$20\,^{\circ}\mathrm{C}$', ...
       '$30\,^{\circ}\mathrm{C}$', ...
       '$40\,^{\circ}\mathrm{C}$');

%% 2, 3, 4
figure;
plot(lambda, y(1:4,:), 'LineWidth', 0.8);
hold on;
plot(lambda, y(5,:), 'LineWidth', 1.5, 'LineStyle', '-');
plot(lambda, y(6,:), 'LineWidth', 1.0, 'LineStyle', '--');

grid on;
grid minor;
xlabel('Wavelength $\lambda$ [$\mu$m]');
ylabel('Spectral radiance');
legend('$10\,^{\circ}\mathrm{C}$', ...
       '$20\,^{\circ}\mathrm{C}$', ...
       '$30\,^{\circ}\mathrm{C}$', ...
       '$40\,^{\circ}\mathrm{C}$', ...
       '$0\,^{\circ}\mathrm{C}$', ...
       'Inf$\,^{\circ}\mathrm{C}$');

%% 5 - Boltman Konstante
T20   = 20 + 273.15;
M     = @(lambda1) (2*h*c^2)./(lambda1.^5)*1./(exp((h*c./(lambda1.*kb*T20)) - 1));
sigma = integral(M, 0, Inf) * 4 * pi / T20^4;

%% 6
% Ultraviolett-Katastrophe
% Rayleigh-Jeans-Gesetz
M = @(lambda1) (2*h*c^2)./(lambda1.^5)*1./(h*c./(lambda1.*kb*T20));
b = integral(M, 0, Inf) * 4 * pi / T20^4;



%% 7

T = 30;
syms M2(l);  
%M2(l, T) = (2*h*c^2)./(l.^5)*1./(exp(h*c./(l.*kb*T)) - 1);
M2(l) = (2*h*c^2)./(l.^5)*1./(exp(h*c./(l.*kb*T)) - 1);
dM2 = diff(M2, l);
equ = dM2 == 0;
a = solve(equ)

l = linspace(1*10^-9, 25e-5, 1000);

% M(lambda)
figure;
plot(l, M2(l));
grid on;
grid minor;

% dM(lambda) / dlambda
figure;
plot(l, dM2(l));
grid on;
grid minor;
