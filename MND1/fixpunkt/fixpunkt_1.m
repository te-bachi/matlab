
close all;
clear;
clc;

%% Farben
% Farbe für f(x)
color_f = [0.0, 0.5, 0.0];

% Farbe für F(x)
color_F  = [0.0, 0.0, 0.5];
color_Fx = [0.5, 0.0, 0.0];

%% Offsets
xoffset = 0.0;
yoffset = 0.0075;


%% Funktionen
% Funktion f(x) = 0
f  = @(x) x.^3 - x + 0.3;
% Funktion F(x) = x
F  = @(x) x.^3 + 0.3;

% Berechnen von f(x)
x_f = linspace(-1,1);
y_f = f(x_f);

% Berechnen von F(x)
x_F = linspace(-1,1);
y_F = F(x_F);

%% Startwerte
x0 = [ -1,  0,  1,  0.5];
y0 = F(x0);

% Länge des Vektors um verschiedene Startwerte
% und Iterationen gleichzeitig zu rechnen
m  = length(x0);

% Iterationsschritte
n  = 8;

% Nur ein Lösung ausgeben
k = 2;

% Fixpunkte initialisieren auf null
x     = zeros(m,n + 1);
y     = zeros(m,n);
konv  = zeros(1,m);

%% Fixpunkte berechnen
x(:,1) = x0;
for i = 1:n
    y(:,i)   = F(x(:,i)); 
    x(:,i+1) = y(:,i);
    
    % Eine Lösung k ausgeben
    fprintf('(x/y) = %8.4f/%8.4f\n', x(k, i), y(k, i));
end

%% Ausgeben jeder einzelnen Lösung
% für unterschiedliche Startwerte
for i = 1:m
    % Jeder zweite Platz resp. nur die linke
    % Seite benutzen: 2*i-1 = 1, 3, 5, 7
    subplot(m,2,2*i-1);
    
    % Zeichne F(x)
    plot(x_F, y_F, 'Color', color_F);
    hold on;
    grid on;
    
    % Konvergiert oder Divergiert?
    konv(i) = (y(i,3) - y(i,2))/(x(i,3) - x(i,2)) < 1;
    if konv(i)
        s = sprintf('F(x%d) => konvergiert', i);
    else
        s = sprintf('F(x%d) => divergiert', i);
    end
    title(s);
    axis([0.295 0.35 0.295 0.35]);
    
    % Schritte als Kreise
    scatter(x(i,2:end-1), y(i,2:end), 'MarkerEdgeColor', 'red');
    
    % Schritte als Text
    for j = 1:length(y)
        xlim_iter = xlim;
        
        % Ränder des Diagrams prüfen und nur dann
        % zeichnen, wenn es innerhalb ist
        if x(i,j) >= xlim_iter(1) && x(i,j) <= xlim_iter(2)
            txt = sprintf('%d', j);
            text(x(i,j) + xoffset, y(i,j) + yoffset, txt);
        end
    end
end

%% Subplot f(x)
subplot(m,2,[2 4]);
plot(x_f, y_f, 'Color', color_f, 'LineWidth', 1.5);
title('f(x)');
hold on;
grid on;

% X-Achse
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);
% Y-Achse
line([0 0], ylim, 'Color', 'black', 'LineWidth', 0.8);

% x = 0
scatter(0, f(0));

% Nullstelle
scatter(x(2,end-2), f(x(2,end-2)));

%% Subplot F(x)
subplot(m,2,[6 8]);
% y = F(x)
plot(x_F, y_F, 'Color', color_F, 'LineWidth', 1.5);
title('F(x)');
hold on;
grid on;
% y = x
plot(x_F, x_F, 'Color', color_Fx, 'LineWidth', 0.75);
% Startwerte
scatter(x0, y0, 'MarkerEdgeColor', 'blue');
% Loesung
scatter(x(1,end-1), y(1,end), 'MarkerEdgeColor', 'red');

% X-Achse
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);
% Y-Achse
line([0 0], ylim, 'Color', 'black', 'LineWidth', 0.8);




%% Ausgeben einer Lösung
for i = 1:m
    if i == k
        figure;
        % Zeichne F(x)
        plot(x_F, y_F, 'Color', color_F);
        hold on;
        grid on;

        % Konvergiert oder Divergiert?
        konv(i) = (y(i,3) - y(i,2))/(x(i,3) - x(i,2)) < 1;
        if konv(i)
            s = sprintf('F(x%d) => konvergiert', i);
        else
            s = sprintf('F(x%d) => divergiert', i);
        end
        title(s);
        axis([0.295 0.35 0.295 0.35]);

        % Schritte als Kreise
        scatter(x(i,2:end-1), y(i,2:end), 'MarkerEdgeColor', 'red');

        % Schritte als Text
        for j = 1:length(y)
            xlim_iter = xlim;

            % Ränder des Diagrams prüfen und nur dann
            % zeichnen, wenn es innerhalb ist
            if x(i,j) >= xlim_iter(1) && x(i,j) <= xlim_iter(2)
                txt = sprintf('%d', j);
                text(x(i,j) + xoffset, y(i,j) + yoffset, txt);
            end
        end
    end
end
