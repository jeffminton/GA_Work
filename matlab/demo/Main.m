
function Main()
%function Main(file)

info = imaqhwinfo('winvideo')
devinfo = imaqhwinfo('winvideo',1);
vid = videoinput('winvideo',1,'RGB24_640x480')

robot = iRobotCreate(0, 4);

%     frame=getsnapshot(vid);
%     imshow(frame);
    
%   frame=imread(file);
NumberOfLines = 0;
cnt = 1;

%Mario Theme
[data, freq] = wavread('mario2.wav');
wavplay(data,freq,'async');

while NumberOfLines ~= 4 &&  cnt < 10   % FIX THESE COUNTS
%    keep rotating left/ccw
    robot.rotate(.2)
    frame=getsnapshot(vid);
    imshow(frame);
    disp('cnt')
    disp(cnt)
    [newdat, NumberOfLines] = linesdemo(frame);
    cnt = cnt+1;

end    
    
    disp('Back in Main Program')
    
%    newdat(1).Centroid(1)
%    disp('Area')
%    newdat(1).Area(1)
%    disp('Length')
%    newdatLength1 = newdat(1).BoundingBox(3);
%    disp(newdatLength1)
%    disp('Width')
%    newdatWidth1 = newdat(1).BoundingBox(4);
%    disp(newdatWidth1)

    %end Joe's code
	%NumberOfLines = length(newdat); 
    disp('#obj')
    disp(NumberOfLines)
    
 %   if NumberOfLines > 1 && NumberOfLines<5,
 %       for d=1: NumberOfLines,
 %           robot.beep()
 %           pause(1)
 %       end
 %   end
    
 
NorthWest = false;
There = false;
centered = false;
 
if NumberOfLines == 4
    NorthWest = false;
    There = false;
    centered = false;
    centered = Center(newdat, robot);
    disp(centered)
    while centered == false,
         frame=getsnapshot(vid);
         imshow(frame);   
         [newdat, unused] = linesdemo(frame);
         centered = Center(newdat, robot);
    end
 %   if centered
    tmc =1;
    There = MoveTo(newdat, robot)
    while There == false && tmc < 9;
       frame=getsnapshot(vid);
       imshow(frame);   
       [newdat, unused] = linesdemo(frame);
       There = MoveTo(newdat, robot)
       tmc = tmc + 1;
    end
    %end

end
  NorthWest = There;
% start northeast
 if NorthWest == true
    disp(' Found NW - rotating 80 degrees CW ')
    %rotate cheat
 %  robot.rotate(-1.6)
    robot.rotate(-2.4)
    %move 3ft cheat
    robot.forward(.9)
    robot.rotate(.4)  
%    robot.forward(.3)    
    NumberOfLines = 0;
    cnt = 1;
    while NumberOfLines ~= 3 && cnt < 10
%   keep rotating
    robot.rotate(-0.2)
    frame=getsnapshot(vid);
    imshow(frame);
    disp('cnt')
    disp(cnt)
    [newdat, NumberOfLines] = linesdemo(frame);
    cnt = cnt+1;
    end
    
    if NumberOfLines == 3
       NorthEast = false;
       There = false;
       centered = false;
       centered = Center(newdat, robot);
       disp(centered)
    while centered == false
         frame=getsnapshot(vid);
         imshow(frame);   
         [newdat, unused] = linesdemo(frame);
         centered = Center(newdat, robot);
    end
 %   if centered
 tmc =1;
    There = MoveTo(newdat, robot)
    while There == false && tmc < 9
       frame=getsnapshot(vid);
       imshow(frame);   
       [newdat, unused] = linesdemo(frame);
       There = MoveTo(newdat, robot)
       tmc = tmc + 1;
    end

    end
 end    
NorthEast = There;
 
% start southheast
 if NorthWest == true && NorthEast == true
    disp(' Found NW & NE - rotating 70 degrees CW ')
    %rotate cheat
 %   robot.rotate(-1.6)
    robot.rotate(-1.7)
    %move 3ft cheat
    robot.forward(1.1)
    robot.rotate(.5)
    NumberOfLines = 0;
    cnt = 1;
    while NumberOfLines ~= 2 && cnt < 10
%   keep rotating
    robot.rotate(-0.2)
    frame=getsnapshot(vid);
    imshow(frame);
    disp('cnt')
    disp(cnt)
    [newdat, NumberOfLines] = linesdemo(frame);
    cnt = cnt+1;
    end
    
    if NumberOfLines == 2
       SouthEast = false;
       There = false;
       centered = false;
       centered = Center(newdat, robot);
       disp(centered)
    while centered == false,
         frame=getsnapshot(vid);
         imshow(frame);   
         [newdat, unused] = linesdemo(frame);
         centered = Center(newdat, robot);
    end
 %   if centered
 tmc =1;
    There = MoveTo(newdat, robot)
    while There == false && tmc < 9;
       frame=getsnapshot(vid);
       imshow(frame);   
       [newdat, unused] = linesdemo(frame);
       There = MoveTo(newdat, robot)
       tmc = tmc + 1;
    end

    end
 end    
SouthEast = There;   

% start southhwest
 if SouthEast == true
    disp(' Found SW - rotating 70 degrees CW ')
    %rotate cheat
%  robot.rotate(-1.6)
    robot.rotate(-1.8)
    %move 3ft cheat
    robot.forward(1.1)
    robot.rotate(.5)
    NumberOfLines = 0;
    cnt = 1;
    while NumberOfLines ~= 2 && cnt < 10
%   keep rotating
    robot.rotate(-0.2)
    frame=getsnapshot(vid);
    imshow(frame);
    disp('cnt')
    disp(cnt)
    [newdat, NumberOfLines] = linesdemo(frame);
    cnt = cnt+1;
    end
    
    if NumberOfLines == 2
       SouthWest = false;
       There = false;
       centered = false;
       centered = Center(newdat, robot);
       disp(centered)
    while centered == false
         frame=getsnapshot(vid);
         imshow(frame);   
         [newdat, unused] = linesdemo(frame);
         centered = Center(newdat, robot);
    end
 %   if centered
 tmc =1;
    There = MoveTo(newdat, robot)
    while There == false && tmc < 9
       frame=getsnapshot(vid);
       imshow(frame);   
       [newdat, unused] = linesdemo(frame);
       There = MoveTo(newdat, robot)
       tmc = tmc + 1;
    end

    end
 end    
SouthWest = There; 

%play success
[data, freq] = wavread('win2.wav');
wavplay(data,freq,'async');
 end   