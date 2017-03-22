
clear all;
close all;
clc;

global KEY_IS_PRESSED;
global CLOSE_FIGURE;
KEY_IS_PRESSED  = 0;
CLOSE_FIGURE    = 0;

% 
omega       = 0;
d_omega     = pi/16;

% Create figure
figure;

% 
set(gcf, 'KeyPressFcn', @myKeyPressFcn);
set(gcf, 'CloseRequestFcn', @myCloseRequestFcn);

%% Wait until key is pressed
while ~KEY_IS_PRESSED
    if CLOSE_FIGURE
        return;
    end
    omega = scheinleistung_draw(omega, 0);
    java.lang.Thread.sleep(100);
    drawnow;
    
end

%% Start animation
disp('start');
KEY_IS_PRESSED = 0;

%% Wait until key is pressed
while ~KEY_IS_PRESSED
    if CLOSE_FIGURE
        return;
    end
    omega = scheinleistung_draw(omega, d_omega);
    drawnow;
    java.lang.Thread.sleep(100);    
end

%% Stop animation
disp('stop');

