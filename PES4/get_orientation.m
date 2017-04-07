
clear all;
close all;
clc;

port = 'COM3';


try
    s = instrfind('Port', port);
    if (strcmp(strjoin(s.Status), 'open') == 0)
        disp('Close opened connection...');
        fclose(s);
    end
    
    disp('Try to open serial...');
    s = serial(port, 'BaudRate', 115200);
    
    fopen(s);
    disp('Succeeded!');

    figure(1);
    counter = 1;

    while 1
        % ax,ay,az, q0,q1,q2,q3 -> Ausgabe im Arduino Script
        rxBuf = fscanf(s, '%f, %f, %f, %f, %f, %f, %f\n');
        a = rxBuf(1:3)';
        q = rxBuf(4:7)';
        %disp(a);
        %disp(q);

        % 
        xAxis = [1 0 0];
        yAxis = [0 1 0];
        zAxis = [0 0 1];
        xAxis = quatrotate(q, xAxis);
        yAxis = quatrotate(q, yAxis);
        zAxis = quatrotate(q, zAxis);
        hold off;
        quiver3(0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 3);
        hold on;
        quiver3(0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 3);
        quiver3(0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 3);

        g = zeros(1,3);
        g(1) = 2*(q(2)*q(4)-q(1)*q(3));
        g(2) = 2*(q(1)*q(2)+q(3)*q(4));
        g(3) = q(1)*q(1)-q(2)*q(2)-q(3)*q(3)+q(4)*q(4);

        g(1) = a(1) - g(1);
        g(2) = a(2) - g(2);
        g(3) = a(3) - g(3);

        %disp(g);

        axis equal;
        axis([-1 1 -1 1 -1 1]);



        if counter >=10;
            counter = 0;
            drawnow;
        end
        counter = counter + 1;
        %disp(counter);


        key = get(gcf, 'CurrentKey');
        if strcmp(key, 'escape')
            break;
        end
    end
    fclose(s);
catch ME
    switch ME.identifier
        case 'MATLAB:serial:fopen:opfailed'
            disp('Cannot open serial!');
            fclose(s);
            rethrow(ME);
            
        otherwise
            disp(ME.identifier);
            
            rethrow(ME);
    end
end
    
