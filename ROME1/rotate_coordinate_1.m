
clear all;
close all;
clc;

% Punkt p0
p0 = [
    2;
    1;
];

% 4 Punkte => 2 Linien => kleine Achsen
xy0 = [
     0,     4,    0,    0;  % x
     0,     0,    0,    4;  % y
];

% Figure Einstellungen
win = [ -10, 10, -10, 10];
figure;
hold on;
grid on;
grid minor;
axis equal;
axis(win);

% Grosse Achsen im den Nullpunkt/Origin
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');

% Plotte Linien (kleine Achsen)
line(xy0(1,:) + 0.05, xy0(2,:) + 0.05, 'Color', 'blue');

% Plotte Punkte
scatter(p0(1), p0(2), 'MarkerEdgeColor', 'blue');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Rotate 1 counter-clockwise


phi1 = pi/8;
R1 = [
    cos(phi1)   -sin(phi1);
    sin(phi1)   cos(phi1);
];

% Punkte translatieren und rotieren
p1 = R1 * p0;

% Linien translatieren und rotieren
xy1 = R1 * xy0;

% Plotte Linien (kleine Achsen)
line(xy1(1,:), xy1(2,:), 'Color', 'red');

% Plotte Punkte
scatter(p1(1), p1(2), 'MarkerEdgeColor', 'red');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Rotate 1 clockwise

R2 = [
    cos(phi1)   sin(phi1);
    -sin(phi1)  cos(phi1);
];

% Punkte translatieren und rotieren
p2 = R2 * p0;

% Linien translatieren und rotieren
xy2 = R2 * xy0;

% Plotte Linien (kleine Achsen)
line(xy2(1,:), xy2(2,:), 'Color', 'green');

% Plotte Punkte
scatter(p2(1), p2(2), 'MarkerEdgeColor', 'green');

