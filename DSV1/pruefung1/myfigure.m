function [ f ] = myfigure(width, height)
    f    = figure();
    res  = get(groot, 'screensize');
    x    = res(3)/2 - width/2;
    y    = res(4)/2 - height/2;
    set(f, 'Position', [x, y, width, height]);
end

