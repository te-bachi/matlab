
clear all;
close all;
clc;

syms a b c d e f g h i x y z;
M = [ a b c; d e f; g h i];
u = [ x; y; z];
v = M * u;

A = [ 2 1 1; 1 2 1; 1 1 2 ];
i = [ 2; 30; 500 ];
k = A * i;
