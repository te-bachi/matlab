
clear all;
close all;
clc;

q1 = [   1.0       0.0       0.0       0.0     ];
q7 = [   0.4284   -0.2863   -0.0451    0.8559  ];
q8 = [   0.2776    0.8976    0.3408   -0.0349  ];

p1 = [ 0;  0;  0 ];
p2 = [ 0;  0; -5 ];
p3 = [ 0;  0; -3 ];

rot1 = quat2rotm(q1);
rot2 = quat2rotm(q7);
rot3 = quat2rotm(q8);

t1          = zeros(4,4);
t1(1:3,1:3) = rot2;
t1(1:3, 4)  = p1;
t1(4,   4)  = 1;

t2          = zeros(4,4);
t2(1:3,1:3) = rot3;
t2(1:3, 4)  = p2;
t2(4,   4)  = 1;

t3          = zeros(4,4);
t3(1:3,1:3) = rot1;
t3(1:3, 4)  = p3;
t3(4,   4)  = 1;

t4          = t1 * t2 * t3;

disp('q7 = ');
disp(q7);

disp('q8 = ');
disp(q8);

disp('t1 = ');
disp(t1);

disp('t2 = ');
disp(t2);

disp('t3 = ');
disp(t3);

disp('t4 = ');
disp(t4);

