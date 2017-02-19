clc, clear all, clf;
M=[-1 0 0 0 0; 4 -1 0 0 0; -1 4 -1 0 0; 0 -1 4 -1 0; 0 0 -1 4 -1; 0 0 0 -1 4; 0 0 0 0 -1];
MT=M';

A=M*MT;

LR_Tridiag_Solver(A)



