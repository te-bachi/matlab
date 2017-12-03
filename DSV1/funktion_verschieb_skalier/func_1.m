
%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

clear all;
close all;
clc;


%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
% Funktion beschreiben
% y = a * f([b * x + c] / d) + e
a = 2;
b = 2;
c = -1;
d = 4;
e = 1;

f1 = @(x) x.^2;

x = linspace(-2, 2);

y1 = f1(x);
y2 = a .* f1(x);
y3 = f1(b .* x);
y4 = f1(x + c);
y5 = f1(x ./ d);
y6 = f1(x) + e;
y7 = f1(x + c) + e;
y8 = f1((b .* x) ./ d);

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
% Funktion plotten

obj = myplot(2, 4, 'Funktionen');
obj.setAxis([ -2 2 -1 5]);
obj.plot(x, y1, {'Original',                         '$y = a \cdot f \big( ( b \cdot x + c ) : d \big) + e $'});
obj.plot(x, y2, {'Streckung/Stauchen in y-Richtung', '$y = a \cdot f ( x )$'});
obj.plot(x, y3, {'Streckungs-/Stauchungsfaktor b',   '$y = f \big( b \cdot x \big)$'});
obj.plot(x, y4, {'Verschieben nach rechts/links',    '$y = f \big( x + c \big)$'});
obj.plot(x, y5, {'Streckung/Stauchen in x-Richtung', '$y = f \big( x : d \big)$'});
obj.plot(x, y6, {'Verschieben nach oben/unten',      '$y = f \big( x \big) + e $'});
obj.plot(x, y7, {'Verschieben',                      '$y = f \big( x + c \big) + e $'});
obj.plot(x, y8, {'Streckung/Stauchen',               '$y = f \big( ( b \cdot x) : d \big)$'});

