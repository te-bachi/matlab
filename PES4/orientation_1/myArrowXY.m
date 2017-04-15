
function [h] = myArrowXY(omega)
    A = 1;
    x = A * cos(omega);
    y = A * sin(omega);
    h = plot3([0, x], [0, y], [0, 0], 'Color', 'black');
end
