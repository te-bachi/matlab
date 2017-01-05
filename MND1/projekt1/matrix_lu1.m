
clc;
clear;

%% Skalierte Matrix A, L�sung b
A_scale = [
  0.22222222     -0.11111111     -0.33333333      0.33333333    ;
  0.50000000      0.00000000     -0.37500000      0.12500000    ;
  0.42857143      0.07142857     -0.07142857      0.42857143    ;
 -0.16666667     -0.41666667      0.33333333      0.08333333    ;
];
b_scale = [
          0.11111111;
          0.25000000;
          0.21428571;
          0.33333333;
];

printmat('A_scale', A_scale);

%% LU Pr�fen

[L, U, P] = lu(A_scale);

printmat('L', L);
printmat('U', U);
printmat('P', P);


