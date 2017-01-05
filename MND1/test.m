
clear;
clc;

A = [
    1 2 3;
    1 1 1;
    3 3 1
];

b = [
    1;
    2;
    3
];


[L,U,P] = lu(A);
y = lr_forward(L,b);
B = lr_backward(U, y);
