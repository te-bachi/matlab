
function axis_set_2pi()
    set(gca,'FontSize',14);
    set(gca, 'xtick', [
        -4/2*pi
        -3/2*pi
        -2/2*pi
        -1/2*pi
        0
        1/2*pi
        2/2*pi
        3/2*pi
        4/2*pi
    ]);
    set(gca, 'xticklabels', ({
        '$$-2\pi$$'
        '$$-\frac{3}{2}\pi$$'
        '$$-\pi$$'
        '$$-\frac{1}{2}\pi$$'
        '$0$'
        '$$\frac{1}{2}\pi$$'
        '$$\pi$$'
        '$$\frac{3}{2}\pi$$'
        '$$2\pi$$'
    }));
    set(gca, 'ytick', [
        -1.00
        -0.75
        -0.50
        -0.25
        0
        0.25
        0.50
        0.75
        1.00
    ]);
    grid on;
    xlim([-2*pi, 2*pi]);
    ylim([-1, 1]);
    line([0 0], ylim, 'Color', 'black', 'LineWidth', 1.5);
    line(xlim, [0 0], 'Color', 'black', 'LineWidth', 1.5);
    %xlabel('$f \left \( t \right \)$', 'Interpreter', 'latex');
    xlabel('$t$');
    ylabel('$f \left ( t \right )$');
    
end