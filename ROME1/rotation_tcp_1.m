
clear all;
close all;
clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter mit Armlängen und Gelenken
q1 = deg2rad(30);
l1 = 0;

q2 = deg2rad(0);
l2 = 5;

q3 = deg2rad(-30);
l3 = 3;

ltcp = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter Arme

% P = [
%     0, l1, l1, l2+l1, l2+l1, l3+l2+l3, l3+l2+l3, ltcp+l3+l2+l3;
%     0,  0,  0,     0,     0,        0,        0,             0;
% ];

A1 = [
     0,                    l1; % x
     0,                     0; % y
     0,                     0; % homogen (nur zum rechnen)
];

A2 = [
    l1,                 l2+l1;
     0,                     0;
     0,                     0;
];

A3 = [
    l2+l1,           l3+l2+l3;
        0,                  0;
        0,                  0;
];
 
ATCP = [
    l3+l2+l3,   ltcp+l3+l2+l3;
           0,               0;
           0,               0;
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Homogene Transformationsmatrizen
T_0_1 = [
    cos(q1),   -sin(q1),    l1;
    sin(q1),    cos(q1),    0;
          0,          0,    1;
];

T_1_2 = [
    cos(q2),   -sin(q2),    l2;
    sin(q2),    cos(q2),    0;
          0,          0,    1;
];

T_2_3 = [
    cos(q3),   -sin(q3),    l3;
    sin(q3),    cos(q3),    0;
          0,          0,    1;
];

T_3_TCP = [
          1,          0,    ltcp;
          0,          1,    0;
          0,          0,    1;
];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arme transformieren
A1   = T_0_1 * A1;
A2   = T_0_1 * T_1_2 * A2;
A3   = T_0_1 * T_1_2 * T_2_3 * A3;
ATCP = T_0_1 * T_1_2 * T_2_3 * T_3_TCP * ATCP;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter zeichnen

% Figure Einstellungen
win = [ -1, 15, -1, 15];
figure;
hold on;
grid on;
grid minor;
axis equal;
axis(win);

% Grosse Achsen im den Nullpunkt/Origin
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');

% Plotte Arme
line(A1(1,1:2), A1(2,1:2), 'Color', 'red');
line(A2(1,1:2), A2(2,1:2), 'Color', 'green');
line(A3(1,1:2), A3(2,1:2), 'Color', 'blue');
line(ATCP(1,1:2), ATCP(2,1:2), 'Color', 'red');
