
clear all;
close all;
clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter mit Armlängen und Gelenken
q1 = deg2rad(60);
l1 = 6;

q2 = deg2rad(-110);
l2 = 4;

q3 = deg2rad(-110);
l3 = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter Arme
%
% Linie muss Anfang und Ende haben:
%
% (x1/y1)          (x2/y2)
%
%    x----------------x
%

% Anfang   Ende
%    |      |
A1 = [
     0,    l1; % x
     0,     0; % y
     0,     0; % z
     0,     0; % homogen (nur zum rechnen)
];

A2 = [
     0,    l2;
     0,     0;
     0,     0;
     0,     0;
];

A3 = [
     0,    l3;
     0,     0;
     0,     0;
     0,     0;
];
 
A4 = [
     0,     0;
     0,     0;
     0,     0;
     0,     0;
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Homogene Transformationsmatrizen
T_0_1 = [
    cos(q1),   -sin(q1),          0,    0;
    sin(q1),    cos(q1),          0,    0;
          0,          0,          1,    0;
          0,          0,          0,    1;
];

T_1_2 = [
    cos(q2),   -sin(q2),          0,    l1;
    sin(q2),    cos(q2),          0,    0;
          0,          0,          1,    0;
          0,          0,          0,    1;
];

T_2_3 = [
    cos(q3),   -sin(q3),          0,    l2;
    sin(q3),    cos(q3),          0,    0;
          0,          0,          1,    0;
          0,          0,          0,    1;
];

T_3_4 = [
          1,          0,          0,    l3;
          0,          1,          0,    0;
          0,          0,          1,    0;
          0,          0,          0,    1;
];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arme transformieren

% Beispiel:
% A1(:,2) = A(Zeile,Spalte) = A(alle Zeilen, Spalte 2)
%
%             Spalte 2
%               |
%       [  a,  *b  ]                 [ b ]
%   A = [  d,  *e  ]    =>  A(:,2) = [ e ]
%       [  g,  *h  ]                 [ h ]


% (x1/y1)          (x2/y2)
%    |       A1       |       A2
%    x----------------x----------------x------...
%                     |                |
%                  (x1/y1)          (x2/y2)

%         Translation vom 
%         Ursprung zu den Punkten
%         für Anfang (1. Spalte)
%         und Ende (2. Spalte)
%         (darum Matrix erzeugen)
A1   =                                 T_0_1                         * A1;
A2   = [A1(:,2) A1(:,2)]            + (T_0_1 * T_1_2                 * A2);
A3   = [A2(:,2) A2(:,2)]            + (T_0_1 * T_1_2 * T_2_3         * A3);
A4   = [A3(:,2) A3(:,2)]            + (T_0_1 * T_1_2 * T_2_3 * T_3_4 * A4);

fprintf('A1   = %2.0f\n', norm(A1(:,2) - A1(:,1)));
fprintf('A2   = %2.0f\n', norm(A2(:,2) - A2(:,1)));
fprintf('A3   = %2.0f\n', norm(A3(:,2) - A3(:,1)));
fprintf('A4   = %2.0f\n', norm(A4(:,2) - A4(:,1)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Roboter zeichnen

create_figure();

% Grosse Achsen im den Nullpunkt/Origin
% plot3(xlim, [0 0 0], [0 0 0], 'Color', 'black');
% plot3([0 0 0], ylim, [0 0 0], 'Color', 'black');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotte Koordinatensystem
k = [
     0,     1,     0,     0; % x
     0,     0,     1,     0; % y
     0,     0,     0,     1; % z
     0,     0,     0,     0; % h
];

k0 =                                      T_0_1                             * k;
k1 = [A1(:,2) A1(:,2) A1(:,2) A1(:,2)]  + T_0_1 * T_1_2                     * k;
k2 = [A2(:,2) A2(:,2) A2(:,2) A2(:,2)]  + T_0_1 * T_1_2  * T_2_3            * k;
k3 = [A3(:,2) A3(:,2) A3(:,2) A3(:,2)]  + T_0_1 * T_1_2  * T_2_3 * T_3_4    * k;

plot_coord(k, 's');
plot_coord(k0);
plot_coord(k1);
plot_coord(k2);
plot_coord(k3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotte Arme
%     Anfang Ende   Anf Ende   Anf Ende
%          | |        | |        | |
plot3(A1(1,1:2), A1(2,1:2), A1(3,1:2), 'Color', 'red');
plot3(A2(1,1:2), A2(2,1:2), A2(3,1:2), 'Color', 'green');
plot3(A3(1,1:2), A3(2,1:2), A3(3,1:2), 'Color', 'blue');
plot3(A4(1,1:2), A4(2,1:2), A4(3,1:2), 'Color', 'red');
%        |          |          |
%        x          y          z

% Nullpunkt
origin = [
    0;      % x
    0;      % y
    0;      % z
    1;      % homogen (nur zum rechnen)
];

% Nullpunkt transformieren
p0 = T_0_1                         * origin;
p1 = T_0_1 * T_1_2                 * origin;
p2 = T_0_1 * T_1_2 * T_2_3         * origin;
p3 = T_0_1 * T_1_2 * T_2_3 * T_3_4 * origin;

fprintf('p0   = [ %4.2f / %4.2f / %4.2f ]\n', p0(1), p0(2), p0(3));
fprintf('p1   = [ %4.2f / %4.2f / %4.2f ]\n', p1(1), p1(2), p1(3));
fprintf('p2   = [ %4.2f / %4.2f / %4.2f ]\n', p2(1), p2(2), p2(3));
fprintf('p3   = [ %4.2f / %4.2f / %4.2f ]\n', p3(1), p3(2), p3(3));

fprintf('len(p1 - p0) = %4.2f\n', norm(p1 - p0));
fprintf('len(p2 - p1) = %4.2f\n', norm(p2 - p1));
fprintf('len(p3 - p2) = %4.2f\n', norm(p3 - p2));

% Plotte Punkte
scatter3(p0(1), p0(2), p0(3), 'MarkerEdgeColor', orange);
scatter3(p1(1), p1(2), p1(3), 'MarkerEdgeColor', 'blue');
scatter3(p2(1), p2(2), p2(3), 'MarkerEdgeColor', 'blue');
scatter3(p3(1), p3(2), p3(3), 'MarkerEdgeColor', 'red');

