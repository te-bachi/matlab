

clear all;
close all;
clc;

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
filename   = 'images/thorax.jpg';
thorax_rgb = imread(filename);

myline();
%--------------------------------------------------------------------------
fprintf('height = %d width = %d channels = %d\n', size(thorax_rgb));
info = imfinfo(filename);
fprintf('ColorType = %s\n', info.ColorType);

myline();
%--------------------------------------------------------------------------
thorax_grey = rgb2gray(thorax_rgb);

figure;

subplot(2, 2, 1);
imshow(thorax_rgb);
title('RGB');

subplot(2, 2, 2);
imshow(thorax_grey, []);
rectangle('Position', [10, 10, 80, 80], 'EdgeColor', 'red');
title('Gray');

subplot(2, 2, [3 4]);
imhist(thorax_grey);

myline();
%--------------------------------------------------------------------------
% Ganzes Bild
meanval = mean2(thorax_grey);
stdval  = std2(thorax_grey);
snr     = meanval / stdval;

fprintf('SNR = %4.2f\n', snr);

myline();
%--------------------------------------------------------------------------
% Region-of-Interest (ROI)80));
thorax_grey_roi = thorax_grey(10:80,10:80);
meanval         = mean2(thorax_grey_roi);
stdval          = std2(thorax_grey_roi);
snr             = meanval / stdval;
fprintf('SNR = %4.2f\n', snr);

figure;

subplot(1, 2, 1);
imshow(thorax_grey_roi);
title('Original');

subplot(1, 2, 2);
imshow(thorax_grey_roi, []);
title('Optimal Intensity');

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
myline();
%--------------------------------------------------------------------------
% Cut and Mirror Image
thorax_grey_right = thorax_grey(:, 257:512);
thorax_grey_left  = fliplr(thorax_grey_right);
thorax_grey_full  = [ thorax_grey_left, thorax_grey_right ];
thorax_grey_small = thorax_grey_full(1:2:end, 1:2:end);
thorax_grey_mask  = thorax_grey_small < 20;
thorax_grey_tk    = thorax_grey_small;
thorax_grey_tk(thorax_grey_mask) = 70;

figure;
subplot(1, 3, 1);
imshow(thorax_grey_full, []);
subplot(1, 3, 2);
imshow(thorax_grey_small, []);
subplot(1, 3, 3);
imshow(thorax_grey_tk, []);


imwrite(thorax_grey_tk, 'images/thorax.png');

