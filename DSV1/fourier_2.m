
clear all;
close all;
clc;

t = 0:0.01:20;

y = 0;
for i = 1:2:100
    y = y + (1/i) * sin(i * t);
end

plot(t, y);
grid on;
grid minor;
