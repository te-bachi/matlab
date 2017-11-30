
clear all;
close all;
clc;


v = [ 1 2 3 4 5 6 ];
w = v.';
A = [1 2 3; 4 5 6; 7 8 9];

myline();
%--------------------------------------------------------------------------
% [ 1 2 3 4 5 6 ]
v

% [ 1
%   2
%   3
%   4
%   5
%   6 ]
w

% [ 1  2  3
%   4  5  6
%   7  8  9 ]
A

myline();
%--------------------------------------------------------------------------
% Eingabe:  v    = [ 1 2 |3| 4 5 6 ]
% Resultat: v(3) = 3
%     Zeile  = 1
% |-- Spalte
v(3)

% Eingabe:  w    = [ 1
%                    2
%                   |3|
%                    4
%                    5
%                    6 ]
% Resultat: w(3) = 3
% |-- Zeile
% |   Spalte = 1
w(3)

% Matrix als Spaltenvektor behandelt!
% Eingabe:  A    = [ 1  2  3
%                    4  5  6
%                   |7| 8  9 ]
% Resultat  A(3) = 7
% |-- Zeile
% |   Spalte = 1
A(3) % 7
A(4) % 2

myline();
%--------------------------------------------------------------------------
% Eingabe:  A    = [ 1 |2| 3
%                    4  5  6
%                    7  8  9 ]
% Resultat  A(3) = 7
% |-- Zeile
% ||- Spalte
A(1,2)

myline();
%--------------------------------------------------------------------------
% Matrix als Spaltenvektor behandelt, Resultat aber als Zeilenvektor!!
% Eingabe:  A    = [|1| 2  3
%                    4  5  6
%                   |7| 8  9 ]
% Resultat  A(3) = [ 1 7 ]             ALS ZEILEN-VEKTOR
% |-- Zeilen 1 + 3
% |   Spalte = 1
A([1 3])  % Output: [ 1 7 ]
A([4 6])  % Output: [ 2 8 ]

myline();
%--------------------------------------------------------------------------
% Eingabe:  A    = [|1| 2  3
%                    4  5  6
%                   |7| 8  9 ]
% Resultat  A(3) = [ 1
%                    7 ]             ALS SPALTEN-VEKTOR
% |-- Zeilen 1 + 3
% |   Spalte = 1
A([1 3], 1)
% A([4 6], 1) ==> Index exceeds matrix dimensions.

myline();
%--------------------------------------------------------------------------
% Eingabe:  A    = [ 1 |2||3|
%                    4  5  6
%                    7 |8||9| ]
% Resultat  A(3) = [ 2  3
%                    8  9 ]
% ?? Zeilen 1 + 3
% ?   Spalte 2 + 3
A([1 3], [2 3])


myline();
%--------------------------------------------------------------------------
% Matrix als SPALTEN-VEKTOR
A(:)
% Matrix als ZEILEN-VEKTOR
A(1:end)

myline();
%--------------------------------------------------------------------------
% Matrix als MATRIX
A(:,:)

myline();
%--------------------------------------------------------------------------
% Summe aus Matrix
% ================
%
% Summe aus jeder SPALTE
sum(A)

% Matrix als SPALTEN-VEKTOR und erst dann summieren: eine Zahl! 
sum(A(:))


myline();
%--------------------------------------------------------------------------
% Summe aus Matrix
% ================
% Erstellen von Matrix:
% 1) Alle Zeilen, Spalte 1
% 2) Alle Zeilen, Spalte 3
M(:,1) = [ 0,  1,  2,  3,  4,  5];
M(:,3) = [12, 10, 15, 12, 11, 13];

M
% M =
% 
%      0     0    12
%      1     0    10
%      2     0    15
%      3     0    12
%      4     0    11
%      5     0    13



