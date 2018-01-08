
clear all;
close all;
clc;

myline();
%--------------------------------------------------------------------------
M = 3;
N = 3;

A = zeros(M,N)
B = ones(M,N)
C = true(M,N)
D = false(M,N)
E = rand(M,N)

M = 5 * B

myline();
%--------------------------------------------------------------------------
a = [ 1 1 1]'
b = [ 2 2 2]
a * b
b * a


myline();
%--------------------------------------------------------------------------
X = [ 1  1;
      2  2;
]
Y = [ 2  3;
      4  5;
]

X .* Y
X * Y