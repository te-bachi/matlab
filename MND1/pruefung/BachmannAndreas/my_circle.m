
function my_circle(x,y,xscale,yscale,r,color)
    ang = 0:0.01:2*pi; 
    xp  = xscale*r*cos(ang);
    yp  = yscale*r*sin(ang);
    plot(x + xp, y + yp, 'Color', color);
end
