
clear all;
close all;
clc;

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
% width  = 358
% height = 418
homer = imread('images/homersimpson.jpg');

myline();
%--------------------------------------------------------------------------
fprintf('height = %d width = %d channels = %d\n', size(homer));

myline();
%--------------------------------------------------------------------------
info = imfinfo('images/homersimpson.jpg');
fprintf('ColorType = %s\n', info.ColorType);

myline();
%--------------------------------------------------------------------------
figure
imshow(homer);  

figure
imshow(homer, [240, 255]); % ändert sich nicht: 'truecolor'

figure
imshow(homer, []);

pause;
%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
close all;


myline();
%--------------------------------------------------------------------------
info = imfinfo('images/homersimpson.png');
fprintf('ColorType = %s\n', info.ColorType);
homer = imread('images/homersimpson.png');

figure
imshow(homer);

figure
imshow(homer, [80, 170]); % ändert sich, da 'greyscale'

figure
imshow(homer, []);

myline();
%--------------------------------------------------------------------------
fprintf('height = %d width = %d channels = 0 (grayscale)\n', size(homer));


pause;
%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
close all;

myline();
%--------------------------------------------------------------------------
%figure
%imshow('images/homersimpson.png', [80, 170]);
% ==> ERROR

figure
imshow('images/homersimpson.png');

pause;
%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
close all;

% KEINE veränderung
homer = imread('images/homersimpson.jpg');

figure;
image(homer);

figure;
imagesc(homer);

% von greyscale auf "farbiges bild"
homer = imread('images/homersimpson.png');

figure;
image(homer);

% Index kommt vom Bild (grayscale)
% Index wird in Colormap (Farbtabelle) mit "echter Farbe" gemappt.
% Die Colormap wird von MATLAB gemacht.
figure;
imagesc(homer);

pause;
%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
close all;
clear all;
clc;

% Lade Built-In "spine" !!
load spine;

figure
imshow(X);

Y = ind2gray(X, map);
figure
imshow(Y);

figure
imshow(Y, []);

figure
imshow(Y, [1 255]);

pause;
%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
close all;
clear all;
clc;

homer_rgb         = imread('images/HomerSimpson.jpg');
homer_gray        = rgb2gray(homer_rgb);
homer_gray_uint8  = im2uint8(homer_gray);
homer_gray_double = im2double(homer_gray);

figure
subplot(1, 2, 1);
imshow(homer_gray_uint8, []);
subplot(1, 2, 2);
imshow(homer_gray_double, []);

imwrite(homer_gray_double, 'images/MyHomerSimpson_gray.tif');
info = imfinfo('images/MyHomerSimpson_gray.tif')
fprintf('ColorType = %s\n', info.ColorType);

homer_ind_uint8 = gray2ind(homer_gray_uint8);
imwrite(homer_ind_uint8, 'images/MyHomerSimpson_ind.tif');
info = imfinfo('images/MyHomerSimpson_ind.tif')
fprintf('ColorType = %s\n', info.ColorType);


