clear all, clc, clf
A=[-39.4 -64.4 21.1; -66.1 -91.3 19.5; -128.2 -65.3 21; 45.5 -50 19.9; -144.6 51.6 21.5]*1000;
v=300000000;
b= [0.298 0.421 0.535 0.213 0.562]'*v;

x1=A'*A\A'*b
L=chol(A'*A,'lower')
y=forward(L,A'*b)
x=backward(L',y)