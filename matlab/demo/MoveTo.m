function [There] = MoveTo( newdat, robot )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
newdatWidth1 = newdat(1).BoundingBox(4);
There = false;
disp('In MoveTo Func')
disp(newdatWidth1)
    if newdatWidth1 >= 0 && newdatWidth1 <= 12,
        %move robot forward 3ft
        robot.forward(.9)
        disp('moving 3 feet')
        %remove for actual robot
        %There = true;
    
    elseif newdatWidth1 >= 13 && newdatWidth1 <= 36,
        %move robot forward 1ft
        robot.forward(.3)
        disp('moving 1 feet')
        %remove for actual robot
        %There = true;

    elseif newdatWidth1 >= 37,
            %move robot forward 6in
            robot.forward(.18)
            disp('moving 6 in')
            There = true;
                
    end   
end

