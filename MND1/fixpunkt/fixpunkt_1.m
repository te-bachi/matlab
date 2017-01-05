
clear;
clc;

% Startwerte und Iterationsschritte
x0 = [ -1,  0,  1,  0.5];
m  = length(x0);
n  = 8;

% Funktionen
f  = @(x) x.^3 - x + 0.3;
F  = @(x) x.^3 + 0.3;

% Initialisieren
x     = zeros(m,n + 1);
y     = zeros(m,n);
konv  = zeros(1,m);

%% Berechnen
x(:,1) = x0;
for i = 1:n
    y(:,i)   = F(x(:,i)); 
    x(:,i+1) = y(:,i);
end

%% Ausgeben jeder einzelnen Lösung
% für unterschiedliche Startwerte
for i = 1:m
    subplot(m,2,2*i-1)
    plot(x(i,2:end-1), y(i,2:end));
    
    % Konvergiert oder Divergiert?
    konv(i) = (y(i,3) - y(i,2))/(x(i,3) - x(i,2)) < 1;
    if konv(i)
        s = sprintf('F(x%d) => konvergiert', i);
    else
        s = sprintf('F(x%d) => divergiert', i);
    end
    title(s);
    hold on;
    grid on;
    axis([0.295 0.35 0.295 0.35]);
    scatter(x(i,2:end-1), y(i,2:end));
end

%%
x_f = linspace(-1,1);
y_f = f(x_f);
subplot(m,2,2);
plot(x_f, y_f);
title('f(x)');
hold on;
grid on;
scatter(0, f(0));
scatter(x(2,end-2), f(x(2,end-2)));


