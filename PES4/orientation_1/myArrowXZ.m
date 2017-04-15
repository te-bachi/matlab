
function [h] = myArrowXY(omega)
    A = 1;
    x = A * cos(omega);
    z = A * sin(omega);
    h = plot3([0, x], [0, 0], [0, z], 'Color', 'black');
end
