
close all;
clc;

clear Coordinate;
clear MainFigure;
clear Robot;
clear SerialPort;
clear Transformation;

try
    fig = MainFigure();
    %fig.update();
catch ME
    disp(ME.identifier);
    rethrow(ME);
end

% if exist('fig', 'var')
%     delete(fig);
% end
% if exist('c', 'var')
%     delete(c);
% end
