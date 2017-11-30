

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

%     for k = 1:xmax
%         img_project = img_orig(:, 1)';
%         img(k, :)   = img(k, :) + img_project;
%     end

img_orig    = im2double(img_grey);
img_size    = size(img_grey);
xmax        = img_size(1);
ymax        = img_size(2); 
img         = zeros(xmax, xmax);
img_project = zeros(xmax, xmax);
omega       = 10;
figure;
%for i = 1:2
    for k = 1:xmax
        img_project(k, :) = img_orig(:, 1)';
    end
    img = img;
    %imagesc(img_project);
    
    %img         = img + img_project;
    %imshow(img);
    %pause;
%end

imshow(img, []);