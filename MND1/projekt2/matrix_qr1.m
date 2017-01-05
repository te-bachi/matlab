
clc;
clear;

A       = [  3,  7;
             0, 12;
             4   1 ];

[Q, R]  = qr(A);

printmat('R', R);
printmat('Q', Q);
