
function axis_set_pi(has_labels)

    if nargin < 1
        has_labels = true;
    end
    
    set(gcf, 'Color', 'white');
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
        '$$-\pi$$'
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
    line([0.01 0.01], ylim, 'Color', 'black', 'LineWidth', 0.8);
    line(xlim, [0.01 0.01], 'Color', 'black', 'LineWidth', 0.8);
    
    if has_labels
        xlabel('$t$');
        ylabel(['$f \left ( t \right )$']);
    end
end