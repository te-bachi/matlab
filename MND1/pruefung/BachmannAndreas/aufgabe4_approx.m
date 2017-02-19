
clear all;
close all;
clc;

f1      = @(x, y)   (x - 1)^2   + 8*(y - 1/2)^2;
f2      = @(x, y)   (x - 1/2)^4 +   (y - 1/2)^4;

% Funktionen
% Funktion F(u) = 0
% x => u(1)
% y => u(2)
F       = @(u) [
    (u(1) - 1)^2   + 8 * (u(2) - 1/2)^2 - 3;
    (u(1) - 1/2)^4 +     (u(2) - 1/2)^4 - 1;
];

% Ableitung => Jacobi-Matrix: dF/dx dF/y
% syms x y;
% diff((x - 1)^2   + 8 * (y - 1/2)^2 - 3, x) => 2*x - 2
% diff((x - 1)^2   + 8 * (y - 1/2)^2 - 3, y) => 16*y - 8
% diff((x - 1/2)^4 +     (y - 1/2)^4 - 1, x) => 4*(x - 1/2)^3
% diff((x - 1/2)^4 +     (y - 1/2)^4 - 1, y) => 4*(y - 1/2)^3
% x => u(1)
% y => u(2)
dF      = @(u) [
    2*u(1) - 2,        16*u(2) - 8;
    4*(u(1) - 1/2)^3,  4*(u(2) - 1/2)^3;
];

tol     = 1e-6; 
iterMax = 200;
iter    = 1;
error   = 1;
m       = 2;

%% Erster Punkt
x       = zeros(m, iterMax);

x(:, 1) = [ 0 0 ];
aufgabe4_funktion;


%% Zweiter Punkt
iter    = 1;
error   = 1;
x       = zeros(m, iterMax);

x(:, 1) = [ -1 -1 ];
aufgabe4_funktion;


%% Dritter Punkt
iter    = 1;
error   = 1;
x       = zeros(m, iterMax);

x(:, 1) = [ -1 2 ];
aufgabe4_funktion;


%% Vierter Punkt
iter    = 1;
error   = 1;
x       = zeros(m, iterMax);

x(:, 1) = [ 3 -1 ];
aufgabe4_funktion;


%% Fuenfter Punkt
iter    = 1;
error   = 1;
x       = zeros(m, iterMax);

x(:, 1) = [ 3 2 ];
aufgabe4_funktion;



