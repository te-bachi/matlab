
%%
clear all;
close all;
clc;

%%
img_x = 640;
img_y = 480;
img_n = 401;


%%
fprintf('Loading...\n');
load('irdata_binary');
fprintf('Success!\n');

%%
progress = 0;
for k = 1:img_n
    imshow(img(:,:,k), [], 'Colormap', jet(255));
    java.lang.Thread.sleep(10);
    if mod(k - 1, 100) == 0
        fprintf('%i%%\n', progress);
        progress = progress + 25;
    end
end

%%

%% Signal s(t)
fs      = 4;                % sampling frequency
C       = 10;               % cycles
f       = 0.1;              % frequency

Tstep   = 1/fs;
Tend    = C/f;
t       = 0:Tstep:Tend;

%% 
dA   = zeros(img_x, img_y);
dphi = zeros(img_x, img_y);
for x = 1:img_x
    for y = 1:img_y
        % Signal/Pixel über die Zeit
        g = zeros(1, img_n);
        for k = 1:img_n
            g(1, k) = img(x,y,k);
        end
        
        % Standard lock-in method (SLIM)
        pf        = g .* sin(2*pi*f*t);
        qf        = g .* cos(2*pi*f*t);

        SPf       = sum(pf);
        SQf       = sum(qf);
        dphi(x,y) = atan(SQf/SPf);
        dA(x,y)   = 2/length(t) * sqrt(SPf^2 + SQf^2);
    end
end

%%
figure;
imshow(dA, [], 'Colormap', jet(255));

figure;
imshow(dphi, [], 'Colormap', jet(255));

figure;
imshow(dA, [0.1 0.8], 'Colormap', jet(255));

figure;
imshow(dphi, [0.1 0.8], 'Colormap', jet(255));
