function [centered] = Center( newdat, robot)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
disp('In centered func')
centered = false;
    if newdat(1).Centroid(1) > 316,
        %rotate robot left
        robot.rotate(-.003)
        disp(newdat(1).Centroid(1))
        %imtool('n_six.jpg')
    end
    if newdat(1).Centroid(1) < 289,
        %rotate robot right sligthly diff amnt than left rotation
        robot.rotate(.004)
        disp(newdat(1).Centroid(1))
    end
    if newdat(1).Centroid(1) <= 315 && newdat(1).Centroid(1) >= 290
        %imtool('n_one.jpg')
        centered = true;
        robot.beep()
        robot.beep()
    end

        

end
