

clear all;
close all;
clc;

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
filename  = 'images/sinogram.png';
img_grey  = imread(filename);
info      = imfinfo(filename);

fprintf('height = %d width = %d channels = %d\n', size(img_grey));
fprintf('ColorType = %s\n', info.ColorType);

figure;

subplot(1, 2, 1);
imshow(img_grey, []);
title('Gray');

ax2 = subplot(1, 2, 2);
imagesc(img_grey);
colormap(ax2, jet);
title('Intensity');

myline();
%--------------------------------------------------------------------------
% Ganzes Bild

p           = im2double(img_grey);
[M, P]      = size(p);
N           = floor(M / sqrt(2));
%N           = M;
%N           = 8;
img         = zeros(N, N);
theta       = deg2rad(0:10:170);
costheta    = cos(theta);
sintheta    = sin(theta);
% x           = repmat([ -3, -2, -1,  0,  1,  2,  3,  4], 8, 1);
% y           = repmat([  3;  2;  1;  0; -1; -2; -3; -4], 1, 8);
x           = repmat([ -(N/2 - 1):1:N/2], N, 1);
y           = repmat([  N/2 - 1:-1:-N/2]', 1, N);
ctrIdx      = ceil(size(p,1) / 2);

figure;

for i = 1:length(theta)
    proj = p(:,i);
    t    = round(x*costheta(i) + y*sintheta(i));
    img  = img + proj(t + ctrIdx);
    imshow(t, []);
    pause;
end

%--------------------------------------------------------------------------
% Intensität skalieren auf 0...1 (double)
% und anschliessend auf uint8 konvertieren
intensity_max = max(img(:));
img = img / intensity_max;
img = im2uint8(img);


%--------------------------------------------------------------------------
% Speichern und Anzeigeb
imwrite(img, 'images/sinogram_resultat.png');

figure;
imshow(img, []);
