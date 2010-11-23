function [edges] = findObjects(img)

%copy input image
imgBak = img;

%set segments to find
segments = 5;

%write the original image to disk
imwrite(img, 'imgout/segOrig.jpg');

%segment the image
[segment_masks gray] = segmentImage(img, segments);

%write the grayscale segmented image to disk
imwrite(gray, 'imgout\segGray.jpg');

%initialize the edges struct
edges = segment_masks;

%perform task on each segment mask returned
for i = 1:size(segment_masks, 2)
    %copy image to segImg for masking
    segImg = imgBak;
    %turn the segment_mask at i into a 3 dimensional matrix
    rgb_segment_mask = repmat(segment_masks{i}, [1, 1, 3]);
    %set pixels in segImg to 0 where they are 0 in mask
    segImg(rgb_segment_mask == 0) = 0;
    %write segmented color file to disk
    imwrite(segImg, ['imgout\segColor', num2str(i), '.jpg']);
    %perform edge detection on segment mask i
    edges{i} = edge(segment_masks{i});
    %write edge image to disk
    imwrite(edges{i}, ['imgout\edges', num2str(i), '.jpg']);
    %write mask to disk
    imwrite(segment_masks{i}, ['imgout\segMasks', num2str(i), '.jpg']);
end