

%%
clear all;
close all;
clc;

q = [1, 2, 3];
w = [7, 8];
p = [q, w];

%%
A = importdata('Cstep.txt');
B = importdata('Cstep_fine.txt');

[t1, y1] = my_mtf(A);
[t2, y2] = my_mtf(B);

figure;
plot(t1, y1);
hold on;
plot(t2, y2);
grid on;
grid minor;
legend('A', 'B');