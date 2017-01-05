
function axis_set(title)
    set(gca,'FontSize',14);
    set(gca, 'xtick', [
        -4/4*pi
        -3/4*pi
        -2/4*pi
        -1/4*pi
        0
        1/4*pi
        2/4*pi
        3/4*pi
        4/4*pi
    ]);
    set(gca, 'xticklabels', ({
        '$$\fontsize{12}{0}-\pi$$'
        '$$-\frac{3}{4}\pi$$'
        '$$-\frac{2}{4}\pi$$'
        '$$-\frac{1}{4}\pi$$'
        '$0$'
        '$$\frac{1}{4}\pi$$'
        '$$\frac{2}{4}\pi$$'
        '$$\frac{3}{4}\pi$$'
        '$$\pi$$'
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
    xlim([-pi, pi]);
    ylim([-1, 1]);
    line([0 0], ylim, 'Color', 'black', 'LineWidth', 1.5);
    line(xlim, [0 0], 'Color', 'black', 'LineWidth', 1.5);
    %xlabel('$f \left \( t \right \)$', 'Interpreter', 'latex');
    xlabel('$t$');
    ylabel(['$f \left ( t \right ) =', title, '$']);
    
end