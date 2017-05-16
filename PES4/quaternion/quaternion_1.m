
clear all;
close all;
clc;

rotx = [
    1,      0,      0,      0;
    0,      0,     -1,      0;
    0,      1,      0,      0;
    0,      0,      0,      1;
];

rot_y_x = [
    0,      0,      1,      0;
    0,     -1,      0,      0;
    1,      0,      0,      0;
    0,      0,      0,      1;
];

q1 = [1 0 0 0];
q2 = tform2quat(rot_y_x);
q3 = tform2quat(rotx);
q4 = quatmultiply(q2, q3);
q5 = quatinv(q2);

rot4 = quat2rotm(q4);
rot5 = quat2rotm(q5);

disp('q1 = ');
disp(q1);

disp('q2 = ');
disp(q2);

disp('q3 = ');
disp(q3);

disp('q4 = ');
disp(q4);

disp('q5 = ');
disp(q5);

disp('rot4 = ');
disp(rot4);

disp('rot5 = ');
disp(rot5);


