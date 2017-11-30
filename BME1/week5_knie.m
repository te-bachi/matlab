
clear all;
close all;
clc;

format long;


phi   = deg2rad(90);
alpha = deg2rad(15);

F_K   = 735.8;
F_B   = 367.9;
F_T   = 36.8;

L_T   = 0.400;
L1    = 0.042;
L2    = 0.035;
L3    = 0.168;
L4    = sin(phi/2) * L_T;
%L5    = (2/3) * L4;
L5     = 0.189; % gerundet!

%F_X   = F_T * sin(phi/2) + F_B * sin(phi/2) + F_M * sin(alpha);

%{
syms F_M;
s = solve(F_B * L5 + F_T * L3 - F_M * L1 + F_M * L2 == 0);
round(s);
%}

F_M = (F_B * L5 - F_T * L3 * sin(phi/2)) / (L2 * cos(alpha) - L1 * sin(alpha));
round(F_M)