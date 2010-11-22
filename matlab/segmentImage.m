function [segment_masks imgGray] = segmentImage(img, segments)
cform = makecform('srgb2lab');

imgGray = rgb2gray(img);
imgBW = im2bw(imgGray, .5);
white = or(imgBW, ~imgBW);

imgLAB = applycform(img, cform);
ab = double(imgLAB(:,:,2:3));
nrows = size(ab, 1);
ncols = size(ab, 2);
ab = reshape(ab, nrows * ncols, 2);
[cluster_idx cluster_centers] = kmeans(ab, segments);
% [cluster_idx] = litekmeans(ab, segments);
pixel_labels = reshape(cluster_idx, nrows, ncols);
segment_masks = cell(1, segments);

scale = 255 / segments;

for i = 1 : segments
    imgGray(pixel_labels == i) = i * scale;
end

for k = 1:segments
    
    mask = white;
    mask(pixel_labels ~= k) = 0;
    filt = ones(7,7)/49;
    maskFilt = imfilter(mask, filt);
    segment_masks{k} = maskFilt;
end

end