
clear all;
close all;
clc;

port = 'COM3';


global CLOSE_FIGURE;
CLOSE_FIGURE = 0;

try
    s = instrfind('Port', port);
    %if (strcmp(strjoin(s.Status), 'open') == 0)
   %     disp('Close opened connection...');
   %     fclose(s);
    %end
    
    disp('Try to open serial...');
    s = serial(port, 'BaudRate', 115200);
    
    fopen(s);
    disp('Succeeded!');

    figure(1);
    hold on;
    
    set(gcf, 'CloseRequestFcn', @myCloseRequestFcn);
    
    
    xAxis = [1 0 0];
    yAxis = [0 1 0];
    zAxis = [0 0 1];
    
    %======================================================================
    ax1 = subplot(1,2,1);
    hold on;
    daspect([1 1 1]);
    win = [ -1, 1, -1, 1, -1, 1];
    axis equal;
    axis(win);
    grid on;
    grid minor;
    
    %======================================================================
    ax2 = subplot(1,2,2);
    hold on;
    daspect([1 1 1]);
    win = [ -1, 1, -1, 1, -1, 1];
    axis equal;
    axis(win);
    grid on;
    grid minor;

    %======================================================================
    for ax = [ax1, ax2]
        r1 = quiver3(ax, 0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 0.5);
        r2 = quiver3(ax, 0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 0.5);
        r3 = quiver3(ax, 0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 0.5);
    end
    
    %======================================================================
    set(ax1, 'CameraViewAngleMode','manual');
    set(ax1, 'CameraViewAngle',10);
    set(ax1, 'CameraPosition', [8.0, 12.0, 10.0]);
    set(ax1, 'DataAspectRatio',[1 1 1]);
    
    set(ax2, 'CameraViewAngleMode','manual');
    set(ax2, 'CameraViewAngle',10);
    set(ax2, 'CameraPosition', [0.0, 0.0, 12.0]);
    set(ax2, 'DataAspectRatio',[1 1 1]);

    while 1
        [rxBuf, count, msg] = fscanf(s, '[ %d ] [ %f, %f, %f, %f ] [ %f, %f, %f ] [ %f, %f, %f, %f ]  [ %f, %f, %f ]\n');

        if (count == 0)
            disp(msg);
            continue;
        end
        
        
        if CLOSE_FIGURE
            break;
        end
        
        key = get(gcf, 'CurrentKey');
        if strcmp(key, 'escape')
            break;
        end
        
        q1 = rxBuf(2:5)';
        p1 = rxBuf(6:8)';
        q2 = rxBuf(9:12)';
        p2 = rxBuf(13:15)';

        [ax1_pa] = my_plot(ax1, q1, q2);
        [ax2_pa] = my_plot(ax2, q1, q2);
        drawnow;
        my_delete(ax1_pa);
        my_delete(ax2_pa);
    end
    
    delete(gcf);
    disp('Closing connection');
    fclose(s);
catch ME
    switch ME.identifier
        case 'MATLAB:serial:fopen:opfailed'
            disp('Cannot open serial!');
            fclose(s);
            rethrow(ME);
            
        otherwise
            disp(ME.identifier);
            
            disp('Close serial');
            fclose(s);
            
            rethrow(ME);
    end
end
    
