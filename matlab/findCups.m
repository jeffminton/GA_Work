%--------------------------------------------------------
% Try to find an object in ycbcr based on lo, hi values
% Also try to place black pixels around border
function [bwf img ccObjs centDat] = findCups(vid, cbAvg, crAvg)
    pause(.1);
    img = getsnapshot(vid);

    offset = 10;
    img = img(190:end,:,:);
    
    imy = rgb2ycbcr(img);
    
    cbLo = cbAvg - offset;
    cbHi = cbAvg + offset;
    crLo = crAvg - offset;
    crHi = crAvg + offset;
    imCb = imy(:,:,2);
    imCr = imy(:,:,3);
    bwCbLo = im2bw(imCb,cbLo/256);
    bwCbHi = im2bw(imCb,cbHi/256);
    bwCrLo = im2bw(imCr,crLo/256);
    bwCrHi = im2bw(imCr,crHi/256);
    
    bwCb = bwCbLo & ~bwCbHi;
    bwCr = bwCrLo & ~bwCrHi;
    
    bw = bwCb & bwCr;
    filt = ones(7,7)/49;
    bwf = imfilter(bw,filt);
    for i = 1:5
        bwf = imfilter(bwf,filt);
    end
    cc = bwconncomp(bwf,4);

    ccObjs = cc.NumObjects;

    centDat = regionprops(cc, 'all');
    
    saveImg(img, bwf);
    
end
      