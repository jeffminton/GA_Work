%--------------------------------------------------------
% Try to find an object in ycbcr based on lo, hi values
function [bw bwf bwb newDat bigDat] = findObjHue(img,lo,hi);
    % parameters to tweak
    [h w depth] = size(img);
    imy = rgb2ycbcr(img);
    im = imy(:,:,2);
    bw = im2bw(img);
    bw = xor(bw,bw);
    bwb = ~bw;
    for r = 1:h
        for c = 1:w
            if im(r,c) > lo & im(r,c) < hi
                bw(r,c) = true;
            else
                bw(r,c) = false;
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
      