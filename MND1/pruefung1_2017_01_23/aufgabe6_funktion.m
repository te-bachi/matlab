
clear all;
close all;
clc;

f_xmin = -1;
f_xmax = 3;
f_ymin = -1;
f_ymax = 3;

% (x - 1)^2 + (y - 1)^2 = 2
xp  = 1;
yp  = 1;
r   = sqrt(2);

% Neuer Plot
figure;
hold on;
grid on;
grid minor;
axis([f_xmin f_xmax f_ymin f_ymax]);
axis equal;
plot(0, 0);

% Achsen zeichnen
line([f_xmin f_xmax], [0 0], 'Color', 'black');
line([0 0], [f_ymin f_ymax], 'Color', 'black');

% Kreis zeichnen
my_circle(xp, yp, r, 'blue');
scatter([xp], [yp], 'MarkerEdgeColor', 'red', 'Marker', '+');

% Cosinus zeichnen
cos_t = linspace(f_xmin, f_xmax);
cos_y = cos(cos_t);
plot(cos_t, cos_y);
