%% Information
% Tested with Matlab R2015a

%% Code
clc; % Clear command window.
clear all; % Get rid of variables from prior run of this m-file.
workspace; % Show panel with all the variables.

% Read in the Video File and get some video-properties
% --> Needed User Input -> avi Filename e.g. 'Kniebeuge.avi' 
vid = VideoReader('NMP_normal.avi'); 
% <-- ******************************************************

vidHeight = vid.Height;
vidWidth = vid.Width;
vidImageCount = vid.NumberOfFrames;
vidFreq = vid.FrameRate;

% Number of markers used in this analysis 
markerCount = 3;

% Show only every X-th frame in the analysis window (for debug purpose
% choose 1 = every Frame)
visualFilter = 5;

% Speed of motion factor, ranging from 1 - 5. 
% If you made a fast knee flexion choose a higher value (3 - 5) 
% else a lower (1 - 3). If you have an error during the measurement, 
% (--> Error in ==> plausibilityCheck) try to vary the factor. 
% --> Needed User Input -> speed factor 
speed = 2;
% <-- ******************************************************

% Marker Size factor, ranging from 1 - 6. 
% To detect your markers, it is important to aprrox. know how tall the markers are 
% in your video. The size depends on the video resolution and your distance
% to the camera. If your video is recorded on low res. (640x480) choose a
% lower factor (1 - 3), if you made a HD video (1920x1080) choose a higher 
% factor (3 - 6). If you have an error during the measurement (--> Error in ==> markerInit), 
% try to vary the factor. 
% --> Needed User Input -> marker Size factor 
markerSize = 5;
% <-- ******************************************************

% Control variable, ranging from 0 - 1, to define how "round" the markers 
% are in the black/white video. If the algorithm recognises false "round" 
% objects (other than the markers), but whom look more or less like markers, 
% try to vary this variable.
% --> Needed user input value from 0 = not round to 1 = perfect round 
roundness = 0.5;
% <-- ******************************************************

% Offset (mm) between right foot and body center. The value is needed 
% for OpenSim, it represents the "fake" z-position of the three marker.
% --> Needed User Input -> in 'mm' 
zCoord = 140;
% <-- ******************************************************


% Extremity length
% --> Needed User Input -> Distance from hip marker to ankle marker in 'mm'
leg = 870; 
% <-- ******************************************************

for frame = 1:vidImageCount
    
    images = read(vid,frame);
    
    % Threshold the image to get a binary image (only 0's and 1's) of class "logical."
    % --> You can adjust the threshold value (here 0.6) if the RGB start frame picture is
    % poorly converted to black and white. 
    binaryImage = im2bw(images, 0.6);
    % <-- ******************************************************
    
    binaryImage = imfill(binaryImage, 'holes');
    binaryImage = bwareaopen(binaryImage, 100);
    
    % Find the white contours and return the boundary pixels
    [B,L] = bwboundaries(binaryImage,'noholes');
    
    % Measure properties of image regions with regionprops
    % L (built with "bwboundaries") is a Matrix where every region is labeld with a positive integer.
    % with regionprops the properties "Area - (num of Pixels)" and "Centroid - Position (x,y)" of each region are
    % measured
    stats = regionprops(L,'Area', 'Centroid', 'Perimeter');
    
    % Initialise the markers with an input of the user
    if(frame == 1)
      % Create a figure
      figure('Name','Find and trace joint markers');
      set(gcf, 'Position', 0.8*get(0, 'ScreenSize'));
        
      % show the init Frame of the rgb video
      subplot(1, 2, 1);   
      imshow(images);
      title('Original RGB Picture of frame one');
      hold on;
      
      % find the initial Positions of the Markes
      initPos = markerInit(B, L, binaryImage, zCoord, markerSize, roundness);

      % write the initial values in the Marker_x arrays
      Marker_1 = initPos(1,:);
      Marker_2 = initPos(2,:);
      Marker_3 = initPos(3,:);
    end
    
    % loop over the recognized regions and write the right marker coords in
    % an array and the associated text file
    for objNr = 1:length(B)     
        % read centroid data in variable
        centroid = round(stats(objNr).Centroid);
        
        % Write the correct marker coords in the matrix        
        if(plausibilityCheck([centroid(1), centroid(2)], Marker_1, frame, speed))
            Marker_1 = [Marker_1;[centroid(1), centroid(2),zCoord, objNr]];
        end
        
        if(plausibilityCheck([centroid(1), centroid(2)], Marker_2, frame, speed))
            Marker_2 = [Marker_2;[centroid(1), centroid(2),zCoord, objNr]];
        end
        
        if(plausibilityCheck([centroid(1), centroid(2)], Marker_3, frame, speed))
            Marker_3 = [Marker_3;[centroid(1), centroid(2),zCoord, objNr]];
        end
    end
    
    % show the Markers on different backgrounds and modifications
    if (mod(frame,visualFilter) == 0) % just update the pics every 5th frame
        % Show the real video
        subplot(1, 3, 1);
        title('Original video');
        imshow(images);
        hold on;
        
        % Plot the recognized marker positions in a graph
        subplot(1, 3, 3);
        title('Marker coordinates with line connection');
        grid on;
        axis([0 vidWidth 0 vidHeight]);
    
        plot(Marker_1(frame,1),vidHeight - Marker_1(frame,2),'ro','MarkerFaceColor','r','MarkerSize',10);
        plot(Marker_2(frame,1),vidHeight - Marker_2(frame,2),'bo','MarkerFaceColor','b','MarkerSize',10);
        plot(Marker_3(frame,1),vidHeight - Marker_3(frame,2),'go','MarkerFaceColor','g','MarkerSize',10);
        
        % Plot the connections *bones* between the Markers
        line([Marker_1(frame,1),Marker_2(frame,1)],[vidHeight - Marker_1(frame,2),vidHeight - Marker_2(frame,2)],'Color','k','LineStyle',':','LineWidth',0.1);
        line([Marker_2(frame,1),Marker_3(frame,1)],[vidHeight - Marker_2(frame,2),vidHeight - Marker_3(frame,2)],'Color','k','LineStyle',':','LineWidth',0.1);
        hold on;
        
        % Plot the black/white frames with colored markers
        temparray = size(L);
        for zeile = 1: temparray(1)
            for spalte = 1: temparray(2)
                if (L(zeile,spalte) == Marker_1(frame + 1,4))
                    % Print marker_1 in red
                    L(zeile,spalte) = 1;
                elseif(L(zeile,spalte) == Marker_2(frame + 1,4))
                    % Print marker_2 in blue
                    L(zeile,spalte) = 3;
                elseif(L(zeile,spalte) == Marker_3(frame + 1,4))
                    % Print marker_3 in green
                    L(zeile,spalte) = 2;
                else
                    L(zeile,spalte) = 0;
                end
            end
        end
        subplot(1, 3, 2);
        title('Video with recognized markers');
        imshow(label2rgb(L, 'hsv', 'k'))
        hold on;
        drawnow;
    end
    
    % Shows Progress of the calculation in Command Window
    clc;
    fprintf(1,num2str(round(frame/vidImageCount*100)))
    fprintf(1,' percent done')
end


% Conversion of the marker coordinates
% 1. First Step, change the origin of the coordinate System from
% "Top-Left" to the middle of the foot (OpenSim Motion cap. standard)

% Make the inital markerpos of the ankle to the origin of the new CordSys.
origin = Marker_3(1,1:3);

for u = 1:size(Marker_1,1)
    % Transform Markerset
    T_Marker_1(u,:) = [Marker_1(u,1) - origin(1), origin(2) - Marker_1(u,2), zCoord];
    T_Marker_2(u,:) = [Marker_2(u,1) - origin(1), origin(2) - Marker_2(u,2), zCoord];
    T_Marker_3(u,:) = [Marker_3(u,1) - origin(1), origin(2) - Marker_3(u,2), zCoord]; 
end

% length of the leg in pixels (in upright standing)
l_leg = sqrt((T_Marker_1(1,1) - T_Marker_3(1,1))^2 + (T_Marker_1(1,2) - T_Marker_3(1,2))^2);

% scale factor
sclfct = leg / l_leg;

for u = 1:size(Marker_1,1)
    % Scale markers according to measured extremity length
    S_Marker_1(u,:) = [T_Marker_1(u,1) * sclfct, T_Marker_1(u,2) * sclfct, zCoord];
    S_Marker_2(u,:) = [T_Marker_2(u,1) * sclfct, T_Marker_2(u,2) * sclfct, zCoord];
    S_Marker_3(u,:) = [T_Marker_3(u,1) * sclfct, T_Marker_3(u,2) * sclfct, zCoord];
end



% Write Header of .trc file for OpenSim
fid = fopen('Bewegungsdaten.trc', 'w');
fprintf(fid,'PathFileType\t4\t(X\\Y\\Z)\tstudent_motion.trc');
fprintf(fid,'\nDataRate\tCameraRate\tNumFrames\tNumMarkers\tUnits\tOrigDataStart\tOrigDataStartFrame\tNumFrames');
fprintf(fid,'\n%i\t%i\t%i\t%i\tmm\t%i\t1\t%i', vidFreq, vidFreq, vidImageCount, markerCount, vidFreq, vidImageCount);
fprintf(fid,'\nFrame#\tTime\tHip\t\t\tKnee\t\t\tAnkle');
fprintf(fid,'\n\t\tX1\tY1\tZ1\tX2\tY2\tZ2\tX3\tY3\tZ3');
fclose(fid);

% Write marker coordinates in the .trc File
dlmwrite('Bewegungsdaten.trc', [[1:vidImageCount + 1]', [0:1/vidFreq:vidImageCount/vidFreq]', S_Marker_1, S_Marker_2, S_Marker_3], '-append', 'delimiter', '\t', 'roffset', 2);
