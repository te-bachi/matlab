% =========================================================
% DSV1, Praktikum Spektrogramm; Marcel Rupf; 23.03.2010
% Version: 6.7.2017
% =========================================================
clear; close all;

% Parameter
% =========================================================
fs=8000;    % Abtastfrequenz
N=10000;    % Anzahl Samples total
NFFT=128;   % FFT-Blocklänge
M=floor(N/NFFT);    % Anzahl Zeitschlitze bzw. FFT-Zeitfenster 

% Zeitsignal
% =========================================================
f0=500;
f1=2200;
x=sin(2*pi*f0*[0:N-1]/fs); 
x=x+[zeros(1,N/2) sin(2*pi*f1*[N/2:N-1]/fs)];
x(1000)=x(1000)+5;
x = x/max(x);

% Audiosignal
% xaudio=wavread('klavier');
% [xaudio, fs]=audioread('post.wav');x=xaudio';N=length(x);M=floor((N-NFFT)/offset);  
% audio=audioplayer(x,fs);play(audio)


figure(1)
subplot(2,1,1);
plot([0:N-1]/fs,x,'o-'); grid;
xlabel('Zeit [s] \rightarrow'); ylabel('x(t) \rightarrow'); title('Zeitsignal');

% Spektrogramm
% ========================================================

% Fenster
% h=hann(NFFT)'; % Hanning-Fenster
h=rectwin(NFFT)'; % kein Fenster

X=ones(NFFT/2,M); 

% bitte hier Code einfüllen !!!!!!!!!!!!!!!!!!!!!!!!!!!!

X=10*log10(X/max(max(X))); % Normierung maximal 0 dB !!!

subplot(2,1,2);
xachse=[0:M-1]*NFFT/fs;
yachse=[0:NFFT/2-1]*(fs/NFFT)/1000;
X=X+64; % Abbildung -64 dB ... 0 dB auf Farben 1...64
image(xachse,yachse,X);
colormap(jet); 
% colormap(gray);
colorbar;
xlabel('Zeit [s] \rightarrow'); ylabel('\leftarrow Frequenz [kHz]'); title('Spektrogramm');
% print -dpng tmp

