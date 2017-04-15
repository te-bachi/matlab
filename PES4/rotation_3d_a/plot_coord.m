function [h1, h2, h3] = plot_coord(coord, style)
    switch nargin
        case 2
            if (style == 'b')
                width = 3.0;
            elseif (style == 's')
                width = 0.25;
            end
        otherwise
            width = 2.0;
    end
    h1 = plot3([coord(1,1) coord(1,2)], [coord(2,1) coord(2,2)], [coord(3,1) coord(3,2)], 'Color', 'r', 'LineWidth', width);
    h2 = plot3([coord(1,1) coord(1,3)], [coord(2,1) coord(2,3)], [coord(3,1) coord(3,3)], 'Color', 'g', 'LineWidth', width);
    h3 = plot3([coord(1,1) coord(1,4)], [coord(2,1) coord(2,4)], [coord(3,1) coord(3,4)], 'Color', 'b', 'LineWidth', width);
end