
clear all;
close all;
clc;

phi1 = pi/8;
R1 = [
    cos(phi1)   -sin(phi1);
    sin(phi1)   cos(phi1);
];

phi2 = -pi/12;
R2 = [
    cos(phi2)   -sin(phi2);
    sin(phi2)   cos(phi2);
];

% Punkt p0
p0 = [
    4;
    4;
];

% 4 Punkte => 2 Linien => kleine Achsen
xy0 = [
     0,     4,    0,    0;  % x
     0,     0,    0,    4;  % y
];

% Linien rotieren
xy1 = R1 * xy0;

% Punkt rotieren
p1 = R1 * p0;

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
scatter(p0(1), p0(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Q

t = [
    4;
    1;
];

% Punkt q0
q0 = [
    4;
    4;
];

% 4 Punkte => 2 Linien => kleine Achsen
xy_b_0 = [
     0,     4,    0,    0;  % x
     0,     0,    0,    4;  % y
];

% Punkte translatieren
q1 = t + q0;

% Linien translatieren
xy_b_0 = [t, t, t, t] + xy_b_0;

% Linien rotieren
xy_b_1 = R1 * xy_b_0;
xy_b_2 = R1 * xy_b_1;

% Plotte Linien (kleine Achsen)
line(xy_b_0(1,:), xy_b_0(2,:), 'Color', 'red');
line(xy_b_1(1,:), xy_b_1(2,:), 'Color', 'red');

% Plotte Punkte
scatter(q1(1), q1(2), 'MarkerEdgeColor', 'yellow');
