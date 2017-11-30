
clear all;
close all;
clc;

sig      = [1 1 1 1 0 0 0 0];
N        = length(sig);
SIG      = sig * dftmtx(N);
sigrueck = (1/N)*(SIG*conj(dftmtx(N)));
