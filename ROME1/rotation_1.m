
clear all;
close all;
clc;

phi = pi/8;
R = [
    cos(phi)   -sin(phi);
    sin(phi)   cos(phi);
];

p1 = [
    5;
    0;
];

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
line(xlim, [0 0], 'Color', 'black');
line([0 0], ylim, 'Color', 'black');
scatter(p1(1), p1(2));
scatter(p2(1), p2(2));
scatter(p3(1), p3(2));
scatter(p4(1), p4(2));
scatter(p5(1), p5(2));
