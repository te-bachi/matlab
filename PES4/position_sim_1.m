
clear all;
close all;
clc;


T1 = [
    1,      0,      0,      1;
    0,      1,      0,      1;
    0,      0,      1,      0;
    0,      0,      0,      1;
];

T2 = [
    1,      0,      0,      1;
    0,      1,      0,      1;
    0,      0,      1,      0;
    0,      0,      0,      1;
];

q1 = [1, 0, 0, 0];

R1 = quat2rotm(q1);

figure(1);
% quiver3(0, 0, 0, [1], [0], [0]);
quiver3(0, 0, 0, 1, 0, 0);
hold on;


daspect([1 1 1]);


win = [ -1, 1, -1, 1, -1, 1];
axis equal;
axis(win);

set(gca,'CameraViewAngleMode','manual');
set(gca,'CameraViewAngle',10);
set(gca,'DataAspectRatio',[1 1 1]);

set(gca, 'XTick', -1:0.25:1);
set(gca, 'YTick', -1:0.25:1);
set(gca, 'ZTick', -1:0.25:1);

