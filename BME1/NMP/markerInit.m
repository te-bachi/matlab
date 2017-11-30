function [initPos] = markerInit(B, L, img, zCoord, markerSize, roundness)

counter = 1; % Counter variable for statemachine

for objNr = 1:length(B)
    
    % Measure properties of image regions with regionprops
    % L (built with "bwboundaries") is a Matrix where every region is labeld with a positive integer.
    % with regionprops the properties "Area - (num of Pixels)" and "Centroid - Position (x,y)" of each region are
    % measured
    stats = regionprops(L,'Area', 'Centroid', 'Perimeter');
    
    % get the object's perimeter
    perimeter = stats(objNr).Perimeter;
    
    % obtain the area calculation corresponding to label 'objNr'
    area = stats(objNr).Area;
    
    % compute the roundness metric
    metric = (4*pi*area)/(perimeter^2);
    
    % read centroid data in variable
    centroid = round(stats(objNr).Centroid);
    
    % Define an threshold for the "roundness" of recognized objects. As higher
    % the Value as rounder the object.
    threshold = roundness;
    maxArea = markerSize * 400;
    minArea = markerSize * 100;
    
    if ((metric > threshold) && (area < maxArea) && (area > minArea))
        initPos(counter,:) = [centroid(1), centroid(2), zCoord, objNr]
        counter = counter + 1;
    end
end

% sort the Markers, so that Marker_1 = Hip (on top), Marker_2 = Knee (on the middle), Marker_3 = Ankle (on the bottom) 
initPos = sortrows(initPos,2);

% plot the first BW image
subplot(1, 2, 2);
set(gcf, 'Position', 0.8*get(0, 'ScreenSize'));
imshow(img);
title('Black-White Picture with recognized markers of frame one');
hold on;

% mark the recognized markers with a red boundary
for t = 1:3
    marker = B{initPos(t,4)};
    plot(marker(:,2), marker(:,1), 'r', 'LineWidth', 3);
end

% User interaction to check if the makers are correct recognized
reply = input('Are the Markers recognized well (red circles)? Y/N: ', 's');
if (reply == 'Y' || reply == 'y')
    disp('OK, automatic marker tracking startet'); % Message sent to command window.
else
    close;
    error('Script aborted. Try to adjust the factor "markerSize" to recognize the markers automatically')
end

end



