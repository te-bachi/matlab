
clear classes;
clear all;
close all;
clc;

a = deg2rad(90);

t1 = Transformation([0;0;0], 0, 0, a);
t2 = Transformation([0;0;0], 0, a, 0);
t3 = Transformation([0;0;0], 0, a, a);

t4 = t2 * t1;

disp('t1 = ');
disp(t1.m);

disp('t2 = ');
disp(t2.m);

disp('t3 = ');
disp(t3.m);

disp('t2 * t1 = ');
disp(t4.m);

