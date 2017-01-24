clear all
clc

xi = [-4,-2,0,2,4]';
ni = [53, 260, 405, 204, 67]';

m=length(ni);
n=2;

A = [ones(m,1),xi.^2]

[Q,R] = qr(A,0)

v = backward(R,Q'*log(ni))

sigma = 1/sqrt(-2*v(2))