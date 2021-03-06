
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
    
    set(gca,'CameraViewAngleMode','manual');
    set(gca,'CameraViewAngle',10);
    set(gca,'CameraPosition', [8.0, 12.0, 10.0]);
    set(gca,'DataAspectRatio',[1 1 1]);

    while 1
        % ax,ay,az, q0,q1,q2,q3
        [rxBuf,count,msg] = fscanf(s, '%f, %f, %f, %f, %f, %f, %f\n');
        if (count == 0)
            disp(msg);
            continue;
        end
        
        a = rxBuf(1:3)';
        q = rxBuf(4:7)';

        % 
        xAxis = [1 0 0];
        yAxis = [0 1 0];
        zAxis = [0 0 1];
        xAxis = quatrotate(q, xAxis);
        yAxis = quatrotate(q, yAxis);
        zAxis = quatrotate(q, zAxis);
        
        if CLOSE_FIGURE
            break;
        end
        p1 = quiver3(0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 3);
        p2 = quiver3(0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 3);
        p3 = quiver3(0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 3);

        g    = zeros(1,3);
        g(1) = 2*(q(2)*q(4)-q(1)*q(3));
        g(2) = 2*(q(1)*q(2)+q(3)*q(4));
        g(3) = q(1)*q(1)-q(2)*q(2)-q(3)*q(3)+q(4)*q(4);

        g(1) = a(1) - g(1);
        g(2) = a(2) - g(2);
        g(3) = a(3) - g(3);

        %disp(g);

        drawnow;
        
        key = get(gcf, 'CurrentKey');
        if strcmp(key, 'escape')
            break;
        end
        
        %java.lang.Thread.sleep(100);
        delete(p1);
        delete(p2);
        delete(p3);
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
    
