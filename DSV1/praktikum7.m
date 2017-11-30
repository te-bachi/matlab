% =========================================================
% DSV1
% Praktikum 7
% =========================================================
clear;
close all;
clc;

% Parameter
% =========================================================
fs      = 8000;             % Abtastfrequenz
N       = 10000;            % Anzahl Samples total
NFFT    = 128;              % FFT-Blocklänge
offset  = NFFT/2;           % Offset zwischen 2 FFT-Blöcken
M       = floor(N/NFFT);    % Anzahl Zeitschlitze bzw. FFT-Zeitfenster
NWIN    = 5;

% Zeitsignal
% =========================================================
f0      = 500;
f1      = 2200;
x       = sin(2*pi*f0*[0:N-1]/fs); 
% Erster Teil bis N/2 bleibt gleich => zeros(1,N/2)
% Zweiter Teil von N/2 bis N wird die Frequenz f1 überlagert
x       = x + [zeros(1,N/2) sin(2*pi*f1*[N/2:N-1]/fs)];

% Nach 1'000/8'000 = 1/8 = 0.125 s einen Ausschlag von +5
x(1000) = x(1000)+5;

% Normieren ?!
x       = x/max(x);

% size([0:N/4])     => 2501
% size(x(1, 1:N/4)) => 2500
% plot([0:N/32], x(1, 1:N/32+1))
% x(1, 1:8)

% Audiosignal
% xaudio=wavread('klavier');
% [xaudio, fs]=audioread('post.wav');x=xaudio';N=length(x);M=floor((N-NFFT)/offset);  
% audio=audioplayer(x,fs);play(audio)


figure(1)
subplot(NWIN,1,1);

% N  = 10'000
% fs =  8'000
% t  = N / fs = 1.25 s
plot([0:N-1]/fs,x,'o-');
grid;
%xlim([0,1.25]);
xlabel('Zeit [s] \rightarrow');
ylabel('x(t) \rightarrow');
title('Zeitsignal');

% Spektrogramm
% ========================================================

% Fenster
% h=hann(NFFT)'; % Hanning-Fenster
h       = rectwin(NFFT)'; % kein Fenster

X       = ones(NFFT/2,M); 

% bitte hier Code einfüllen !!!!!!!!!!!!!!!!!!!!!!!!!!!!

subplot(NWIN,1,2);

y       = x(1, 1:N/2 - 1);
Y       = abs(fft(y));
scatter(y, Y, 'b');
hold on;
plot(y, Y, 'r');
xlabel('Frequenz [kHz] \rightarrow');
ylabel('\leftarrow X(F) [A]');
title('FFT x(1:N/2 - 1)');

%-------------------------------------------------------
subplot(NWIN,1,3);

y       = x(1, N/2:N);
Y       = abs(fft(y));
scatter(y, Y, 'b');
hold on;
plot(y, Y, 'r');
xlabel('Frequenz [kHz] \rightarrow');
ylabel('\leftarrow X(F) [A]');
title('FFT x(N/2:N)');

%-------------------------------------------------------
subplot(NWIN,1,4);

% y = x(1, NFFT)
% y = x(1, 128);
m       = 1;
y       = x((m-1) * offset + 1:(m-1)*offset + NFFT);
Y       = abs(fft(h.*y)).^2;
scatter(y, Y, 'b');
hold on;
plot(y, Y, 'r');
xlabel('Frequenz [kHz] \rightarrow');
ylabel('\leftarrow X(F) [A]');
title('FFT x(1:128)');

%-------------------------------------------------------

for m = 1:M,
    %           von               : bis
    y       = x((m-1) * offset + 1:(m-1)*offset + NFFT);
    Y       = abs(fft(h.*y)).^2;
    X(:,m)  = Y(1:NFFT/2)';
end
% bitte hier Code einfüllen !!!!!!!!!!!!!!!!!!!!!!!!!!!!

X       = 10*log10(X/max(max(X))); % Normierung maximal 0 dB !!!

subplot(NWIN,1,5);
xachse  = [0:M-1]*NFFT/fs;
yachse  = [0:NFFT/2-1]*(fs/NFFT)/1000;
X       = X+64; % Abbildung -64 dB ... 0 dB auf Farben 1...64
image(xachse,yachse,X);
colormap(jet); 
% colormap(gray);
colorbar;
xlabel('Zeit [s] \rightarrow');
ylabel('\leftarrow Frequenz [kHz]');
title('Spektrogramm');
% print -dpng tmp

