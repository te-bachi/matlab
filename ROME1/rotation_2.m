
clear all;
close all;
clc;

phi = pi/8;
R = [
    cos(phi)   -sin(phi);
    sin(phi)   cos(phi);
];

p0 = [
    5;
    0;
];

xy0 = [
     0,     4;  % x
     0,     0;  % y
];

xy1 = R * xy0;
xy2 = R * xy1;
xy3 = R * xy2;
xy4 = R * xy3;
xy5 = R * xy4;

p1 = R * p0;
p2 = R * p1;
p3 = R * p2;
p4 = R * p3;
p5 = R * p4;

win = [ -10, 10, -10, 10];
figure;
hold on;
grid on;
grid minor;
axis equal;
axis(win);
% Achsen
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');

% Kleine Achsen, die drehen
line(xy0(1,:), xy0(2,:), 'Color', 'blue');
line(xy1(1,:), xy1(2,:), 'Color', 'blue');
line(xy2(1,:), xy2(2,:), 'Color', 'blue');
line(xy3(1,:), xy3(2,:), 'Color', 'blue');
line(xy4(1,:), xy4(2,:), 'Color', 'blue');
line(xy5(1,:), xy5(2,:), 'Color', 'blue');

% Punkte
scatter(p1(1), p1(2));
scatter(p2(1), p2(2));
scatter(p3(1), p3(2));
scatter(p4(1), p4(2));
scatter(p5(1), p5(2));

%% Q

t = [
    4;
    1;
];

q0 = [
    3;
    2;
];

xy_b_0 = [
     0,     4,    0,    0;  % x
     0,     0,    0,    4;  % y
];

% Punkt A translatieren
xy_b_0 = xy_b_0 + [t, t, t, t];

xy_b_1 = R * xy_b_0;
xy_b_2 = R * xy_b_1;
xy_b_3 = R * xy_b_2;
xy_b_4 = R * xy_b_3;
xy_b_5 = R * xy_b_4;

% Kleine Achsen, die drehen
line(xy_b_0(1,:), xy_b_0(2,:), 'Color', 'red');
line(xy_b_1(1,:), xy_b_1(2,:), 'Color', 'red');
line(xy_b_2(1,:), xy_b_2(2,:), 'Color', 'red');
line(xy_b_3(1,:), xy_b_3(2,:), 'Color', 'red');
line(xy_b_4(1,:), xy_b_4(2,:), 'Color', 'red');
line(xy_b_5(1,:), xy_b_5(2,:), 'Color', 'red');

