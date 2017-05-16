
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
    
    % Koordinatensystem
    quiver3(0, 0, 0, 0.1, 0.0, 0.0, 'r');
    quiver3(0, 0, 0, 0.0, 0.1, 0.0, 'g');
    quiver3(0, 0, 0, 0.0, 0.0, 0.1, 'b');
    
    daspect([1 1 1]);

    win = [ -1, 1, -1, 1, -1, 1];
    axis equal;
    axis(win);
    
    grid on;
    grid minor;
    
    xAxis = [1 0 0];
    yAxis = [0 1 0];
    zAxis = [0 0 1];
    
    set(gca, 'CameraViewAngleMode','manual');
    set(gca, 'CameraViewAngle',10);
    set(gca, 'CameraPosition', [8.0, 12.0, 10.0]);
    set(gca, 'DataAspectRatio',[1 1 1]);

    r1 = quiver3(0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 0.5);
    r2 = quiver3(0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 0.5);
    r3 = quiver3(0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 0.5);

    while 1
        [rxBuf, count, msg] = fscanf(s, '[ %d ] [ %f, %f, %f, %f ] [ %f, %f, %f ] [ %f, %f, %f, %f ]  [ %f, %f, %f ]\n');

        if (count == 0)
            disp(msg);
            continue;
        end
        
        
        if CLOSE_FIGURE
            break;
        end
        
        q1 = rxBuf(2:5)';
        p1 = rxBuf(6:8)';
        q2 = rxBuf(9:12)';
        p2 = rxBuf(13:15)';

        
        % First Quat
        xAxis = [1 0 0];
        yAxis = [0 1 0];
        zAxis = [0 0 1];
        xAxis = quatrotate(q1, xAxis);
        yAxis = quatrotate(q1, yAxis);
        zAxis = quatrotate(q1, zAxis);
        p1 = quiver3(0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 3);
        p2 = quiver3(0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 3);
        p3 = quiver3(0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 3);
        
        % First Quat
        xAxis = [1 0 0];
        yAxis = [0 1 0];
        zAxis = [0 0 1];
        xAxis = quatrotate(q2, xAxis);
        yAxis = quatrotate(q2, yAxis);
        zAxis = quatrotate(q2, zAxis);
        p4 = quiver3(0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 3);
        p5 = quiver3(0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 3);
        p6 = quiver3(0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 3);

        drawnow;
        
        key = get(gcf, 'CurrentKey');
        if strcmp(key, 'escape')
            break;
        end
        
        %java.lang.Thread.sleep(100);
        delete(p1);
        delete(p2);
        delete(p3);
        delete(p4);
        delete(p5);
        delete(p6);
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
    
