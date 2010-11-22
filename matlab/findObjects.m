function [edges] = findObjects(img)

imgBak = img;
segments = 5;

imwrite(img, 'imgout/segOrig.jpg');

[segment_masks gray] = segmentImage(img, segments);

imwrite(gray, 'imgout\segGray.jpg');

edges = segment_masks;

for i = 1:size(segment_masks, 2)
    segImg = imgBak;
    rgb_segment_mask = repmat(segment_masks{i}, [1, 1, 3]);
    segImg(rgb_segment_mask == 0) = 0;
    imwrite(segImg, ['imgout\segColor', num2str(i), '.jpg']);
    edges{i} = edge(segment_masks{i});
    imwrite(edges{i}, ['imgout\edges', num2str(i), '.jpg']);
    imwrite(segment_masks{i}, ['imgout\segMasks', num2str(i), '.jpg']);
%     figure, imshow(edges{i}), title(['edges ', num2str(i)]);
end