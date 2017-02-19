
clear all;
close all;
clc;


syms q1 q2 q3 l1 l2 l3 ltcp;

T_0_1 = [
    cos(q1),   -sin(q1),    0;
    sin(q1),    cos(q1),    0;
          0,          0,    1;
];

T_1_2 = [
    cos(q2),   -sin(q2),    l1;
    sin(q2),    cos(q2),    0;
          0,          0,    1;
];

T_2_3 = [
    cos(q3),   -sin(q3),    l2;
    sin(q3),    cos(q3),    0;
          0,          0,    1;
];

T_3_TCP = [
          1,          0,    l3;
          0,          1,    0;
          0,          0,    1;
];

A = T_0_1 * T_1_2 * T_2_3 * T_3_TCP;
A = simplify(A);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x / y

syms x y;

v0 = [
    1;
    1;
    1;
];

v1 = A * v0;
v1 = simplify(v1);


E = T_0_1 * T_1_2 * T_2_3

simplify(E(1,3))

simplify(diff(simplify(E(1,3)), q1))
simplify(diff(simplify(E(1,3)), q2))

F = [
    simplify(diff(simplify(E(1,3)), q1)), simplify(diff(simplify(E(1,3)), q2));
    1, 1;
];

det(F)
 
