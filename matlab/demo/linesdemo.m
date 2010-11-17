
function [newdat NumberOfLines] = linesdemo(vid)

%     info = imaqhwinfo('winvideo')
%     devinfo = imaqhwinfo('winvideo',1);
%     devinfo = imaqhwinfo('winvideo',1)
%     vid = videoinput('winvideo',1,'RGB24_640x480')
%     cmap = colormap;
%     cmap=brighten(cmap,1);
%     colormap(cmap);   %brighten image
    frame=getsnapshot(vid);
    imshow(frame);
    
%    frame=imread(file);
    grayim = rgb2gray(frame);
    bw = im2bw(grayim,15/256);
    bw2 = ~bw;
 %   figure, imshow(bw2)
    h = ones(2,2)/4;

    bwf = imfilter(bw2,h);

    for i = 1:1

        bwf = imfilter(bwf,h);

    end
   
    figure,imshow(bwf);
    
    
    
    cc1 = bwconncomp(bwf, 8);
%disp('num objects')    
%cc1.NumObjects   
numberOfObjects = cc1.NumObjects; 
linesFound=[];

linedata = regionprops(cc1,'basic');
%imtool(bwf)
if numberOfObjects >= 2
	objectLength = [];
	objectWidth = [];
    objectX = [];
    objectY=[];
    lineList=[];
    onePairFound=false
	for j=1:numberOfObjects,
      objectWidth(j) = linedata(j).BoundingBox(4);
	  objectLength(j) = linedata(j).BoundingBox(3);
      %compare x values to make sure they are withing 100 pixels to dermine
      %if they are under each other
      objectX(j) = linedata(j).BoundingBox(1);
      objectY(j) = linedata(j).BoundingBox(2);
    end
    linedata(1).BoundingBox()
    disp('Width Array')
    disp(objectWidth)
    disp('Length Array')
    disp(objectLength)
%-1
	for i=1:numberOfObjects-1,  %lookup indexing in matlab lists
		thisObjectWidth = objectWidth(i);
%        disp('Original Width')
%        disp(i)
%        disp(thisObjectWidth)
		thisObjectLength = objectLength(i);
        thisX=objectX(i);
        thisY=objectY(i);
%        disp('Original Length')
%        disp(i)
%        disp(thisObjectLength)
        
        if thisObjectWidth>thisObjectLength,   %Verticle Object
            continue
        end
        
        if thisObjectWidth<5 || thisObjectLength<5,                %Minute spot
            continue
        end
        
        if thisObjectWidth<5 && thisObjectLength<5,                %Minute spot
            continue
        end 
        
        if abs(thisObjectWidth-thisObjectLength)<7,     %close to a square
            continue
        end
        
        disp('Width size')
        disp(i)
        disp(length(objectWidth))
        %-1
		for j=i:length(objectWidth)-1,
			differenceWidth = abs(thisObjectWidth - objectWidth(j+1));
%            disp('Other Width')
%            disp(objectWidth(j+1))
%            disp('Diference Width')
%            disp(differenceWidth)
			differenceLength = abs(thisObjectLength - objectLength(j+1));
            disp('thisX')
            disp(thisX)
%            disp('objectX')
%            disp(objectX)
%            disp('thisY')
%            disp(thisY)
%            disp('objectY')
%            disp(objectY)
            differenceX=abs(thisX-objectX(j+1));
            differenceY=abs(thisY-objectY(j+1));
%            disp('Other Length')
%            disp(objectLength(j+1))
%            disp('Diference Length')
%            disp(differenceLength)
            distanceBig=false;
			if (differenceWidth<20 && differenceLength<20 && differenceX<20),
                if(thisObjectLength<50 || thisObjectWidth<50),
                    disp('BIG')
                    disp('DIFFERENCE')
                    disp(differenceY)
                    disp(distanceBig)
                    
                    if(differenceY>150),
                        disp('HEYYYYYYYYYYYYYYYYYYYYYYY')
                        disp('BIGGER')
                        distanceBig=true;
                    end
                end
				if (length(lineList)==0&&distanceBig==false),   %empty list, thisobject not included
					lineList(1)=i;
                    onePairFound=true;
                end
                if (distanceBig==false && onePairFound==true)                                
                    lineList(length(lineList)+1)=j+1;
                end
            end
			
        end
    end
end
                
    disp(lineList)
	linesFound = false(size(bwf)); 
    disp('size of list')
    disp(length(lineList))
	for k=1:  length(lineList),
        disp('Width')
        disp(objectWidth(lineList(k)))
        if((objectLength(lineList(k))>5&&objectWidth(lineList(k))>4)), %once again eleminates small dots
            linesFound(cc1.PixelIdxList{lineList(k)}) = true; %adds the line to the image
            disp('In loop')
            disp(k)
        end
		
    end
	imshow(linesFound);
	cc2 = bwconncomp(linesFound, 4); 

    %begin Joe's code
%    disp('Image Size & Centroid')
%    cc2.ImageSize
    itmData = regionprops(cc2,'basic');
    [unused, order] = sort([itmData(:).Area],'descend');
    newdat=itmData(order);
    
 %   newdat(1).Centroid(1)
 %   disp('Area')
 %   newdat(1).Area(1)
 %   disp('Length')
 %   newdatLength1 = newdat(1).BoundingBox(3);
 %   disp(newdatLength1)
 %   disp('Width')
 %   newdatWidth1 = newdat(1).BoundingBox(4);
 %   disp(newdatWidth1)
 %   imtool(linesFound);
    %end Joe's code
	NumberOfLines = cc2.NumObjects 
    
 %   if NumberOfLines > 1 && NumberOfLines<5,
 %       for d=1: NumberOfLines,
 %           robot.beep()
 %           pause(1)
 %       end
 %   end
    
    
    %can select and display one line
%     line = false(size(bwf));
%     line(cc.PixelIdxList{2}) = true;
%     figure, imshow(line)
    
%if NumberOfLines == 4,

%centered = Center(newdat);
%disp(centered)
%    if centered
%    MoveTo(newdat)
%    end


end