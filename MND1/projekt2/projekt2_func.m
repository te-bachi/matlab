
clc;
clear;

syms x x0 sigma a b y;
f        = exp(-(x - x0)^2 / sigma) * (a * (x - x0)^3 + b * (x - x0));
df_x0    = diff(f, x0)
df_sigma = diff(f, sigma)
df_a     = diff(f, a)
df_b     = diff(f, b)

