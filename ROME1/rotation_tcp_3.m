
clear all;
close all;
clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter mit Armlängen und Gelenken
q1 = deg2rad(45);
l1 = 6;

q2 = deg2rad(45);
l2 = 4;

q3 = deg2rad(45);
l3 = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter Arme

% P = [
%     0, l1, l1, l2+l1, l2+l1, l3+l2+l3, l3+l2+l3, ltcp+l3+l2+l3;
%     0,  0,  0,     0,     0,        0,        0,             0;
% ];

A1 = [
     0,    l1; % x
     0,     0; % y
     0,     0; % homogen (nur zum rechnen)
];

A2 = [
     0,    l2;
     0,     0;
     0,     0;
];

A3 = [
     0,    l3;
     0,     0;
     0,     0;
];
 
ATCP = [
     0,     0;
     0,     0;
     0,     0;
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Homogene Transformationsmatrizen
T_0_1 = [
    cos(q1),   -sin(q1),    0;
    sin(q1),    cos(q1),    0;
          0,          0,    1;
];

T_1_2 = [
    cos(q2),   -sin(q2),    l1;
    sin(q2),    cos(q2),    0;
          0,          0,    1;
];

T_2_3 = [
    cos(q3),   -sin(q3),    l2;
    sin(q3),    cos(q3),    0;
          0,          0,    1;
];

T_3_TCP = [
          1,          0,    l3;
          0,          1,    0;
          0,          0,    1;
];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arme transformieren
% A1   =                      T_0_1   * A1;
% A2   = [A1(:,2) A1(:,2)] + (T_1_2   * A2);
% A3   = [A2(:,2) A2(:,2)] + (T_2_3   * A3);
% ATCP = [A3(:,2) A3(:,2)] + (T_3_TCP * ATCP);

A1   =                      T_0_1                           * A1;
A2   = [A1(:,2) A1(:,2)] + (T_0_1 * T_1_2                   * A2);
A3   = [A2(:,2) A2(:,2)] + (T_0_1 * T_1_2 * T_2_3           * A3);
ATCP = [A3(:,2) A3(:,2)] + (T_0_1 * T_1_2 * T_2_3 * T_3_TCP * ATCP);

fprintf('A1   = %2.0f\n', norm(A1(:,2) - A1(:,1)));
fprintf('A2   = %2.0f\n', norm(A2(:,2) - A2(:,1)));
fprintf('A3   = %2.0f\n', norm(A3(:,2) - A3(:,1)));
fprintf('ATCP = %2.0f\n', norm(ATCP(:,2) - ATCP(:,1)));

% A1   = T_0_1   * A1;
% A2   = T_1_2   * A2;
% A3   = T_2_3   * A3;
% ATCP = T_3_TCP * ATCP;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter zeichnen

% Figure Einstellungen
win = [ -1, 15, -3, 15];
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

% Punkt im TCP berechnen:
tcp = [
    0;
    0;
    1;
];
p0 = T_0_1 *                            tcp;
p1 = T_0_1 * T_1_2 *                    tcp;
p2 = T_0_1 * T_1_2 * T_2_3 *            tcp;
p3 = T_0_1 * T_1_2 * T_2_3 * T_3_TCP *  tcp;

fprintf('p1-0   = %2.0f\n', norm(p1 - p0));
fprintf('p2-1   = %2.0f\n', norm(p2 - p1));
fprintf('p3-2   = %2.0f\n', norm(p3 - p2));

% Plotte Punkte
scatter(p0(1), p0(2), 'MarkerEdgeColor', orange);
scatter(p1(1), p1(2), 'MarkerEdgeColor', 'blue');
scatter(p2(1), p2(2), 'MarkerEdgeColor', 'blue');
scatter(p3(1), p3(2), 'MarkerEdgeColor', 'red');

