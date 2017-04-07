
clear all;
close all;
clc;

%%-------------------------------------------------------------------------
global KEY_IS_PRESSED;
global CLOSE_FIGURE;
KEY_IS_PRESSED  = 0;
CLOSE_FIGURE    = 0;

% Create figure
myCreateFigure();

% 
set(gcf, 'KeyPressFcn', @myKeyPressFcn);
set(gcf, 'CloseRequestFcn', @myCloseRequestFcn);

%%-------------------------------------------------------------------------

%% Wait until key is pressed
while ~KEY_IS_PRESSED
    if CLOSE_FIGURE
        return;
    end
    java.lang.Thread.sleep(100);
    drawnow;
    
end

%% Start animation
disp('start');
KEY_IS_PRESSED = 0;

%% Wait until key is pressed
omega   = 0;
omega_d = pi / 64;
while ~KEY_IS_PRESSED
    if CLOSE_FIGURE
        return;
    end
    h1 = myArrowXY(omega);
    h2 = myArrowXZ(omega);
    drawnow;
    java.lang.Thread.sleep(100);
    delete(h1);
    delete(h2);
    omega = omega + omega_d;
end

%% Stop animation
disp('stop');

