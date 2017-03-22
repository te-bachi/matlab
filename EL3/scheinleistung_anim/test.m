
clear all;
close all;
clc;

figure;

for i = 1:20
    x = i;
    y = x^2;
    
    % Plot point
    plot(x,y, 'o');
    
    % Set grid and axis
    grid on;
    grid minor;
    axis([0 20 0 400]);
    
    % Draw NOW!
    drawnow;
    
    pause(1/2);
end