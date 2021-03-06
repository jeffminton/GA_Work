%--------------------------------------------------------
% Try to find an object in hsi based on lo, hi values
% Also try to place black pixels around border
function [bw bwf bwb newDat bigDat] = findObj(img,lo,hi);
    % parameters to tweak
    % delta for amount of difference
    % d for how far to look for a difference
    %delta = 10;
    %d = 7;
    [h w depth] = size(img);
    im = rgb2hsi(img);
%    int16(im);
    bw = im2bw(img);
    bw = xor(bw,bw);
    bwb = ~bw;
%    sum = ones(1,1,'int16');
%    difN = ones(1,1,'int16');
%    difS = ones(1,1,'int16');
%    difE = ones(1,1,'int16');
%    difW = ones(1,1,'int16');
%    sumDelta = ones(1,1,'int16');
    for r = 1:h
        for c = 1:w
%            sum = int16(im(r,c,2)) + int16(im(r,c,3));
%            difN = abs((int16(im(r-d,c,2)) + int16(im(r-d,c,3))) - sum);
%            difS = abs((int16(im(r+d,c,2)) + int16(im(r+d,c,3))) - sum);
%            difE = abs((int16(im(r,c+d,2)) + int16(im(r,c+d,3))) - sum);
%            difW = abs((int16(im(r,c-d,2)) + int16(im(r,c-d,3))) - sum);
%            sumDelta = max([difN difS difE difW]);
%            if sum > lo & sum < hi
%                bw(r,c) = true;
%            else
%                bw(r,c) = false;
%            end
%            if sumDelta < delta
%                bwb(r,c) = true;
%            else
%                bwb(r,c) = false;
%            end
            if im(r,c) > lo & im(r,c) < hi
                bw(r,c) = false;
            else
                bw(r,c) = true;
            end
        end
    end
    filt = ones(7,7)/49;
    bwf = imfilter(bw,filt);
    for i = 1:5
        bwf = imfilter(bwf,filt);
    end
    cc = bwconncomp(bwf,4);
    itmData = regionprops(cc,'all');
    [unused, order] = sort([itmData(:).Area],'descend');
    newDat = itmData(order);
    bigDat = newDat(1);
end
      