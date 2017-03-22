
%% Stützstelle
% Andreas Bachmann
% 15.03.2017

%
%  int(f, 0, 4)
%
%  |___ ___ ___ ___ ___
%  |   |   |   |   |   |
%  |   |   |   |   |   |
% _|___|___|___|___|___|
%  |
%  t0  t1  t2  t3  t4  t5 <= Stützstellen
%   h0  h1  h2  h3  h4    <= Schrittweite

clear;
close all;
clc;

% f: Funktion
f = @(x) 1*x;

% h: Schrittweite, _NICHT_ Anzahl Schrittweiten!!
%    Muss kleiner als (b - a) sein 
a = 0;
b = 2;
h = 0.5;
n = (1 / h) + 1;
t = linspace(a, b, n);

if ((b - a) < h)
    error(['h must be lower than (b - a)!']);
end

fprintf('Schrittweite        h = %f\n', h);
fprintf('Anzahl Stützstellen n = %d\n', n);

for k = 2:length(t)
    t(k)
    if (k == 2 || k == length(t))
        
    else
        
    end
    
    fprintf('k  = %d\n', k);
    
    fprintf('Ik = %f\n', k);
    
end
