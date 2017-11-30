function [bool] = plausibilityCheck(actualPos, priorPos, frame, speed)
%PLAUSIBILITYCHECK function checks, if the movement of the markers makes sense 
% This is done by comparing the coordinates of each marker at T and T + 1. If the
% displacement is within a plausible range, the new marker Pos is
% accepted else the coordinates at T are written again.

accuracyX = speed * 10;
accuracyY = speed * 10;

bool = 0;

if((actualPos(1) >= (priorPos(frame, 1) - accuracyX)) && ...
   (actualPos(1) <= (priorPos(frame, 1) + accuracyX)) && ...
   (actualPos(2) >= (priorPos(frame, 2) - accuracyY)) && ...
   (actualPos(2) <= (priorPos(frame, 2) + accuracyY)))
    
    bool = 1; 
else
    bool = 0;
end
end



