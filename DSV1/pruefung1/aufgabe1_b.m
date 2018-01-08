
clear all;
close all;
clc;

%--------------------------------------------------------------------------
% Gegeben: fs + N
% Rechnet: T
f0   = 50;
fs   = 1000;
N    = 20;

%--------------------------------------------------------------------------
T    = (N-1)/fs;
Ts   = 1/fs;
Tdft = fs * N;
df   = fs / N;

n    = [0:1:N-1];                        % für Zeit- und Frequenz benutzt

t    = [0:1/fs:T+Ts];                    % Nur für Zeit benutzt, eine Ts mehr anzeigen
x    = cos(2 * pi * f0 * [n, N] / fs);   % Nur für Zeit benutzt, ein n (= N) mehr anzeigen

fprintf('len(n) = %d\n',    length(n));
fprintf('len(t) = %d\n',    length(t));
fprintf('len(x) = %d\n',    length(x));
fprintf('fs     = %d\n',    fs);
fprintf('N      = %d\n',    N);
fprintf('T      = %1.4f\n', T);
fprintf('Ts     = %1.4f\n', 1/fs);
fprintf('Tdft   = %d\n',    Tdft);
fprintf('df     = %d\n',    df);

%--------------------------------------------------------------------------
% Figure 1
figure;

%--- X-Achse n ---
b = axes('Position',[0.1, 0.1, 0.8, 1e-12]);
set(b, 'Units','normalized');
set(b, 'Color','none');

%--- X-Achse t ---
a=axes('Position',[0.1, 0.2, 0.8, 0.7]);
set(a,'Units','normalized');

title('Zeitbereich');
stem(t, x);
hold on;
plot(t, x);
grid on;
grid minor;

%--- X-Achsen Parameter ---
xlabel(a,'Zeit t [s]');
xlabel(b, 'Index n (diskrete Zeit n*Ts)');
xlim(a, [0 T+Ts]);      % eine Ts mehr anzeigen
%a.XTick = [0:Ts:T];
xlim(b, [0 N]);         % ein n (= N) mehr anzeigen
b.XTick = [0:1:N];      % ein n (= N) mehr anzeigen

%--- Y-Achsen Parameter ---
ylabel('Abtastwerte x[n]');
ylim([min(x) max(x)]);

%--- Null-Linie ---
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);

%--------------------------------------------------------------------------
%
y = dft(x, N);

%--------------------------------------------------------------------------
% Figure 2
figure;

%--- X-Achse m ---
b = axes('Position',[0.1, 0.1, 0.8, 1e-12]);
set(b, 'Units','normalized');
set(b, 'Color','none');

%--- X-Achse f ---
a=axes('Position',[0.1, 0.2, 0.8, 0.7]);
set(a,'Units','normalized');

stem(n*fs/N, real(y), 'Color', 'red');
hold on;
stem(n*fs/N, imag(y), 'Color', 'blue');
%stem(n*fs/N, abs(y));
grid on;
grid minor;

%--- X-Achsen Parameter ---
xlabel(a, 'Frequenz f [Hz]');
xlabel(b, 'Index m');
xlim(a, [0 fs]);
xlim(b, [0 fs/df]);
%a.XTick = [0:df:fs];
b.XTick = [0:1:fs/df];


%--- Y-Achsen Parameter ---
ylabel('komplexe Spektralwerte/Frequenzwerte X(f)');
ylim([min(y) max(y)]);

%--- Null-Linie ---
line(xlim, [0 0], 'Color', 'black', 'LineWidth', 0.8);

