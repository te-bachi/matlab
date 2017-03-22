
clear all;
close all;
clc;

syms x y z;
solve(1/8 * exp(-x^2-y^2-z^2) == 0, x)
