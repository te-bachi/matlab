
function [] = myCreateFigure()
    figure(1);
    hold on;
    
    % Koordinatensystem
    quiver3(0, 0, 0, 0.1, 0.0, 0.0, 'r');
    quiver3(0, 0, 0, 0.0, 0.1, 0.0, 'g');
    quiver3(0, 0, 0, 0.0, 0.0, 0.1, 'b');

    %
    daspect([1 1 1]);

    win = [ -1, 1, -1, 1, -1, 1];
    axis equal;
    axis(win);
    
    grid on;
    grid minor;
    
    % Draw plane
    fill3([win(1), win(2), win(2), win(1)],...
          [win(3), win(3), win(4), win(4)],...
          [0,      0,      0,      0],...
          'black'); 
    alpha(0.2);
    
%     fill3([win(1), win(3), 0],...
%           [win(2), win(3), 0],...
%           [win(2), win(4), 0],...
%           [win(1), win(4), 0]); 

    set(gca,'CameraViewAngleMode','manual');
    set(gca,'CameraViewAngle',10);
    set(gca,'CameraPosition', [8.0, 12.0, 10.0]);
    set(gca,'DataAspectRatio',[1 1 1]);

    % Markierung
    set(gca, 'XTick', -1:0.25:1);
    set(gca, 'YTick', -1:0.25:1);
    set(gca, 'ZTick', -1:0.25:1);
end