
clear;
clc;

I       = eye(4);
e1      = I(:,1);
e2      = I(:,2);
H       = @(i,w) (I(i:end,i:end) - 2 * (w*w')/(w'*w));

A0      = [  2,  2,  3,  6  ;
             1,  7,  5,  2  ;
             4,  1,  2,  3  ;
             6,  2,  2,  4 ];

%% 1. Schritt
% A0 = [ 2,  2,  3,  6  ;
%        1,  7,  5,  2  ;
%        4,  1,  2,  3  ;
%        6,  2,  2,  4 ];
%
% y1 = [ 2  ;
%        1  ;
%        4  ;
%        6 ];
y1              = A0(:,1);
w1              = y1 + sign(y1(1)) * norm(y1) * e1(1:end);
H1              = H(1,w1);
Q1              = I;
Q1(1:end,1:end) = H1;
A1              = Q1 * A0;

%% 2. Schritt
% A1 = [ -7.54, -3.57, -4.10, -6.62  ;
%         0.00,  6.41,  4.25,  0.67  ;
%         0.00, -1.33, -0.97, -2.28  ;
%         0.00, -1.50, -2.46, -3.93  ;
%
% y2 = [  6.41  ;
%        -1.33  ;
%        -1.50 ];
y2              = A1(2:end,2);
w2              = y2 + sign(y2(1)) * norm(y2) * e2(2:end);
H2              = H(2,w2);
Q2              = I;
Q2(2:end,2:end) = H2;
A2              = Q2 * A1;

printmat('A0', A0);
fprintf('================\n');
printmat('y1', y1);
printmat('H1', H1);
printmat('Q1', Q1);
printmat('A1', A1);
fprintf('================\n');
printmat('y2', y2);
printmat('H2', H2);
printmat('Q2', Q2);
printmat('A2', A2);

