function saveImg(imgRaw)
    global imgNum;
    imwrite(imgRaw, strcat('imgout\', int2str(imgNum), 'raw.jpg'));
%     imwrite(imgBW, strcat('imgout\', int2str(imgNum), 'bw.jpg'));
    imgNum = imgNum + 1;
end