
%%
clear all;
close all;
clc;

%%
img_x = 640;
img_y = 480;
img_n = 401;


%%
f = zeros(img_x, img_y, img_n);
for k = 1:img_n
    filename = sprintf('irdata/IRdata%i.txt', k);
    f(:,:,k) = load(filename);
    imshow(f(:,:,k), []);
    fprintf('%i ', k);
end