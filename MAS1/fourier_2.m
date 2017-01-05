
clc;
clear;

xmin        = -10;
xmax        = 10;
f           = @(t) 2 * sin((2*pi)/6 * t) + 0.5 * sin((2*pi)/1 * t);
t           = linspace(xmin, xmax, 1000);
y           = f(t);

% Create figure
p1          = plot(t, y, 'Color', 'red');

% Get figure handle
fig         = gcf;
fig.Color   = [ 0.8 0.8 0.8 ];

% Get axis handle of figure
ax          = gca;
xax         = ax.XAxis;
xax.Color   = 'black';

hold on;
grid on;

%
line([0 0], ylim, 'Color', 'blue');
line(xlim, [0 0], 'Color', 'blue');

%drawArrow = @(x,y,varargin) quiver(x(1), y(1), x(2) - x(1), y(2) - y(1), 0, varargin{:});
%drawArrow([0 0], ylim, 'Color', 'blue');
%drawArrow(xlim, [0 0], 'Color', 'blue');

