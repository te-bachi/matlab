
clear all;
close all;
clc;


A = [ 1  2  3;
      4  5  6;
      7  8  9;
];

D = logical([ 1  1  1;
              1  0  1;
              0  1  0]);

myline();
%--------------------------------------------------------------------------
A
D

myline();
%--------------------------------------------------------------------------
% Matrix A geht durch die erste, dann durch die zweite und zum Schluss
% durch die dritte Spalte und schreibt alles in einen SPALTEN-VEKTOR
A(D)

