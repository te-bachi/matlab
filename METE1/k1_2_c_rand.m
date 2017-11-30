
clear all;
close all;
clc;


A        = rand(4,4)
maske    = A > 0.5
A(maske)                    % Ausgabe als SPALTEN-VEKTOR
A(maske) = 0                % Matrix maskieren und die mit maske=1 werden
                            % auf 0 gesetzt.
                            % Ausgabe als MATRIX!

A(:)                        % 