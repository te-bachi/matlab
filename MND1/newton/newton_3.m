
clear;
clc;

%
color = cellstr([ 'red   ';...
                  'blue  ';...
                  'green ';...
                  'cyan  ' ]);

% Startwerte und Iterationsschritte
x0 = 0;
n  = 3;

% Funktionen
% Funktion f(x) = 0
f  = @(x) 1.5.*x.^3 - x + 0.3;
% Ableitung df/dx (x)
df = @(x) 4.5.*x.^2 - 1;


%% Original-Funktion berechen
x_f = linspace(0,1);
y_f = f(x_f);
m_f = length(x_f);

% Initialisieren
x   = zeros(1,n + 1);
y   = zeros(1,n + 1);
t   = zeros(m_f,n);

%% Ausgeben Original-Funktion
plot(x_f, y_f, 'LineWidth', 1, 'Color', [0.0, 0.0, 0.0]);
hold on;
grid on;

% Achsen
xmin =  0.00;
xmax =  0.50;
ymin = -0.10;
ymax =  0.35;
axis([xmin xmax ymin ymax]);

% Null-Linie
plot([xmin xmax], [0, 0], 'Color', [1.0, 0.5, 0.0]);

% Text-Offset
xoffset = 0.005;
yoffset = 0.010;

%% Bereche mit Newton-Verfahren
x(1) = x0;
for i = 1:n+1
    % y-Wert berechnen
    y(i)   = f(x(i));
    
    scatter(x(i), 0, 'filled', 'red');
    scatter(x(i), y(i), 'blue');
    
    x_txt = sprintf('x%d', i - 1);
    y_txt = sprintf('y%d', i - 1);
    text(x(i) + xoffset, 0    - yoffset, x_txt);
    text(x(i) + xoffset, y(i) + yoffset, y_txt);
    
    if (i <= n)
        % Tangente berechnen
        t(:,i) = f(x(i)) + df(x(i)) * (x_f - x(i));
        
        % Ausgeben der Tangenten
        plot(x_f, t(:,i)', ['--', char(color(i,:))]);
        
        % Neuer x-Wert berechnen
        x(i+1) = x(i) - (f(x(i)) / df(x(i))); 
    end
    
end


