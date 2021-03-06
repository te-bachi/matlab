
clear;
clc;

%
color = cellstr([ 'red   ';...
                  'blue  ';...
                  'green ';...
                  'cyan  ' ]);

% Startwerte und Iterationsschritte
x0 = [ 0 ];
m  = length(x0);
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
x   = zeros(m,n + 1);
y   = zeros(m,n + 1);
t   = zeros(m_f,n);

%% Ausgeben Original-Funktion
plot(x_f, y_f, 'LineWidth', 1, 'Color', [0.0, 0.0, 0.0]);
hold on;
grid on;

% Achsen
xmin = 0.0;
xmax = 0.5;
axis([xmin xmax -0.1 0.3]);

% Null-Linie
plot([xmin xmax], [0, 0], 'Color', [1.0, 0.5, 0.0]);

%% Bereche mit Newton-Verfahren
x(:,1) = x0;
for i = 1:n+1
    % y-Wert berechnen
    y(:,i)   = f(x(:,i));
    
    scatter(x(:,i), 0, 'filled', 'red');
    scatter(x(:,i), y(:,i), 'blue');
    if (i <= n)
        % Tangente berechnen
        t(:,i)   = f(x(:,i)) + df(x(:,i)) * (x_f - x(:,i));
        
        % Ausgeben der Tangenten
        plot(x_f, t(:,i)', ['--', char(color(i,:))]);
        
        % Neuer x-Wert berechnen
        x(:,i+1) = x(:,i) - (f(x(:,i)) / df(x(:,i))); 
    end
    
end


