
function [pa] = my_plot(ax, q1, q2)
        % First Quat
        xAxis = [1 0 0];
        yAxis = [0 1 0];
        zAxis = [0 0 1];
        xAxis = quatrotate(q1, xAxis);
        yAxis = quatrotate(q1, yAxis);
        zAxis = quatrotate(q1, zAxis);
        p1 = quiver3(ax, 0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 3);
        p2 = quiver3(ax, 0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 3);
        p3 = quiver3(ax, 0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 3);

        % First Quat
        xAxis = [1 0 0];
        yAxis = [0 1 0];
        zAxis = [0 0 1];
        xAxis = quatrotate(q2, xAxis);
        yAxis = quatrotate(q2, yAxis);
        zAxis = quatrotate(q2, zAxis);
        p4 = quiver3(ax, 0, 0, 0, xAxis(1), xAxis(2), xAxis(3), 'r', 'LineWidth', 3);
        p5 = quiver3(ax, 0, 0, 0, yAxis(1), yAxis(2), yAxis(3), 'g', 'LineWidth', 3);
        p6 = quiver3(ax, 0, 0, 0, zAxis(1), zAxis(2), zAxis(3), 'b', 'LineWidth', 3);

        pa = [p1, p2, p3, p4, p5, p6];
end