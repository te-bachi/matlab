
clear all;
close all;
clc;

M1 = [
    -1   0   0   0   0   0   0;
     4  -1   0   0   0   0   0;
    -1   4  -1   0   0   0   0;
     0  -1   4  -1   0   0   0;
     0   0  -1   4  -1   0   0;
     0   0   0  -1   4   1   0;
     0   0   0   0  -1   0   1;
];

M1T = inv(M1);

A = M1T * M1;

M1
M1T

%%

M2 = [
    -1   0   0   0   0;
     4  -1   0   0   0;
    -1   4  -1   0   0;
     0  -1   4  -1   0;
     0   0  -1   4  -1;
     0   0   0  -1   4;
     0   0   0   0  -1;
];

%M2T = 

     
    