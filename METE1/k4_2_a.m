

clear all;
close all;
clc;

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

N = 256;
A = 10;
B = 20;
M = double(zeros(N, N));
% Rechteck im Zentrum
M(N/2-A/2+1:N/2+A/2, N/2-B/2+1:N/2+B/2) = 1;

F      = fft2(M);
S      = abs(F);
S_real = real(F);
S_imag = imag(F);
Sc     = fftshift(S);

% Inverse
S_inv      = ifftshift(Sc);
M_inv      = abs(ifft2(S_inv));

M_real_inv = real(ifft2(S_real));
M_imag_inv = imag(ifft2(S_imag));

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
figure;

figure_M = 3;
figure_N = 2;
figure_i = 1;

%--------------------------------------------------------------------------

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(M, []);
title('Bildraum');

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(S, []);
title('Frequenzraum');

%--------------------------------------------------------------------------

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(S_real, []);
title('Frequenzraum (reell)');

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(S_imag, []);
title('Frequenzraum (imaginär)');

%--------------------------------------------------------------------------

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(Sc, []);
title('Frequenzraum (shifted)');

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(log(1+Sc), []);
title('Frequenzraum (shifted + amplified)');

%--------------------------------------------------------------------------

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
figure;

figure_M = 3;
figure_N = 1;
figure_i = 1;

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(M_inv, []);

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(M_real_inv, []);

subplot(figure_M, figure_N, figure_i);
figure_i = figure_i + 1;
imshow(M_imag_inv, []);


