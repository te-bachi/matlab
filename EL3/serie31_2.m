
clear all;
close all;
clc;

%   ____
% --____---.-----.
%          |     |
%           >   | |
%           >   | |
%           >   | |
%          |     |
% ---------.-----.

f   = 50;
w   = 2*pi*f;
Uq  = 100;
L   = 100e-3;
R1  = 10;
R2  = 20;

ZR1 = R1;
ZR2 = R2;
ZL  = 1i*w*L;
ZP = (ZL * ZR2) / (ZL + ZR2);
ZG = R1 + ZP;
I1 = Uq / ZG;
% Uq = U1 + U2  =>  U2 = Uq - U1
U2 = Uq - (ZR1 * I1);
IL = U2 / ZL;
I2 = U2 / ZR2;

