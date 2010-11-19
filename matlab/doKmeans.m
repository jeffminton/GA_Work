function doKmeans(img)

cform = makecform('srgb2lab');
imgLAB = applycform(img, cform);
figure, imshow(imgLAB);
ab = double(imgLAB(:,:,2:3));
size(ab)
nrows = size(ab, 1);
ncols = size(ab, 2);
ab = reshape(ab, nrows * ncols, 2);
nColors = 5;
[cluster_idx cluster_center] = kmeans(ab, nColors, 'distance','sqEuclidean', 'Replicates',5);
pixel_labels = reshape(cluster_idx, nrows, ncols);
imshow(pixel_labels, [])
segmented_images = cell(1, 3);
rgb_label = repmat(pixel_labels, [1 1 3]);
for k = 1:nColors
color = img;
color(rgb_label ~= k) = 0;
segmented_images{k} = color;
end

segmented_images

for i = 1 : nColors
    figure, imshow(segmented_images{i}), title(['segment', num2str(i)]);
end
mean_cluster_value = mean(cluster_center, 1);
[tmp, idx] = sort(mean_cluster_value);

idx

for i = 1:size(idx, 1)
    red_cluster_num = idx(i);
    L = imgLAB(:,:,1);
    red_idx = find(pixel_labels == red_cluster_num);
    l_red = L(red_idx);
    is_red = im2bw(l_red, graythresh(l_red));
    cup_labels = repmat(uint8(0), [nrows ncols]);
    cup_labels(red_idx(is_red == false)) = 1;
    cup_labels = repmat(cup_labels, [1 1 3]);
    red_cup = img;
    red_cup(cup_labels ~= 1) = 0;
    figure, imshow(red_cup);
end
end