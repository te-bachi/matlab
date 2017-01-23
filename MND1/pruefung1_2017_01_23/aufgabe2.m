
close all;
clear all;
clc;

% MATLAB: log()   Natural logarithm          => ln()  in TI
% MATLAB: log10() Common logarithm (base 10) => log() in TI

% Nichtlineares Gleichungssystem:
%  2*y - exp(-x*y) = 0
% log(1 + y) - 4*x = 0
%
% x => u(1)
% y => u(2)
f       = @(u) [...
    2*u(2) - exp(-u(1)*u(2));
    log(1 + u(2)) - 4*u(1);
];

% Umgeschrieben auf Fixpunktgleichung:
% I:         2*y = exp(-x*y)
% II: log(1 + y) = 4*x
%
% II:          x = [ log(1 + y) ] / 4
% I:           y = [ exp(-x*y)  ] / 2
%
% x => u(1)
% y => u(2)
F       = @(u) [
    log(1 + u(2)) / 4;
    exp(-u(1)*u(2)) / 2;
];

epsilon = 1;
tol     = 1e-6;
imax    = 200;
i       = 1;

%
% u0 = 0.0    u = 0.0  0.0  0.0  ...
%      0.0        0.0  0.0  0.0  ...
%
% u(:, 1) == u0:
% u(:, 1) = 0.0
%           0.0
u0      = [0.0; 0.0];
u       = zeros(length(u0), imax);
u(:, 1) = u0;

%
fprintf('u(%2d) = %8.6f, %8.6f\n', i, u(:,i));
while (epsilon > tol) && (i <= imax)
    u(:, i + 1) = F(u(:, i));
    epsilon     = norm(u(:, i + 1) - u(:, i), 'inf');
    
    fprintf('u(%2d) = %8.6f, %8.6f\n', i + 1, u(:,i + 1));
    
    i           = i + 1;
end

% Residuum / Güte
r = norm(F(u(:, i)) - u(:, i), 'inf');

% Ueberpruefen:
v = f(u(:, i));
fprintf('v = %8.6f, %8.6f\n', v);
