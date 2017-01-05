
clc;
clear;

%% Skalierte Matrix A, Lösung b
A_scale = [
  0.14285714     -0.07142857     -0.21428571      0.21428571      0.35714286    ;
  0.40000000      0.00000000     -0.30000000      0.10000000      0.20000000    ;
  0.28571429      0.04761905     -0.04761905      0.28571429      0.33333333    ;
 -0.16666667     -0.41666667      0.33333333      0.08333333      0.00000000    ;
  0.04000000      0.28000000      0.08000000      0.36000000      0.24000000    ;
];
b_scale = [
          0.64285714;
          1.00000000;
          4.85714286;
         -2.41666667;
          7.56000000;
];

printmat('A_scale', A_scale);

%% LU Prüfen

[L, U, P] = lu(A_scale);

A_perm = P * A_scale;
printmat('A_perm', A_perm);

z = chol_forward(L, P * b_scale);
x = chol_backward(U, z);

printmat('P', P);
printmat('L', L);
printmat('U', U);
printmat('x', x);

printmat('inv(P) * L * U', inv(P) * L * U);

