
%%
clear all;
close all;
clc;

%% Signal s(t)
fs      = 50;               % sampling frequency
C       = 100;              % cycles

A       = 3;                % amplitude
f       = 0.1;              % frequency
r       = 2*pi/360;         % radiant
k       = r*2;              % phase

Tstep   = 1/fs;
Tend    = C/f;
t       = 0:Tstep:Tend;

T       = A * sin(2*pi*f*t + k);

% bachman0_week2_mywin(t, T);


%% Fast Fourrier Transform (FFT)
T_fft   = fft(T);
T_fft_norm = 2*T_fft/length(T_fft);
dA      = abs(T_fft_norm);
dphi    = atan(imag(T_fft_norm)./real(T_fft_norm));

plot(t, dphi);

dA = max(dA);

fprintf('Fast Fourrier Transform (FFT)\n');
fprintf('A   = %4.6f\n', dA);
fprintf('phi = %4.6f\n', dphi);
fprintf('\n');

%% Standard lock-in method (SLIM)
pf      = T .* sin(2*pi*f*t);
qf      = T .* cos(2*pi*f*t);

% bachman0_week2_mywin(t, pf);
% bachman0_week2_mywin(t, qf);

SPf     = sum(pf);
SQf     = sum(qf);
dphi    = atan(SQf/SPf);
dA      = 2/length(t) * sqrt(SPf^2 + SQf^2);
fprintf('Standard lock-in method (SLIM)\n');
fprintf('A   = %4.6f\n', dA);
fprintf('phi = %4.6f\n', dphi);
fprintf('\n');

%% The 4-bucket method (4BM)

dT      = 4 * fs / f;
s       = fs / f / 4;
T1      = T(0*s+1:dT:end);
T2      = T(1*s+1:dT:end);
T3      = T(2*s+1:dT:end);
T4      = T(3*s+1:dT:end);

S1 = sum(T1)/length(T1);
S2 = sum(T2)/length(T3);
S3 = sum(T3)/length(T3);
S4 = sum(T4)/length(T4);

dphi    = atan((S1 - S3)/(S2 - S4));
dA      = 1/2 * sqrt((S1 - S3)^2 + (S2 - S4)^2);

fprintf('The 4-bucket method (4BM)\n');
fprintf('A   = %4.6f\n', dA);
fprintf('phi = %4.6f\n', dphi);
fprintf('\n');

%% Last Squares Method (LSM)

