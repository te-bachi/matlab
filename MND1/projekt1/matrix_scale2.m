
clc;
clear;

%% Matrix A, Bekannte x
A = [
  2     -1     -3      3      5;
  4      0     -3      1      2;
  6      1     -1      6      7;
 -2     -5      4      1      0;
  1      7      2      9      6;
];

x = [
          6;
          12;
          9;
          7;
          3;
];

% Berechne Lösung b
b = A * x;

b
