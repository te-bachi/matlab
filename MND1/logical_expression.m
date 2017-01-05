
clc;
clear;

syms A N1 N2;
 
L1 = A * N1^2;
L2 = A * N2^2;

logical(A   * N1   * N2   == sqrt(L1 * L2))

logical(A^2 * N1^2 * N2^2 == L1 * L2)
