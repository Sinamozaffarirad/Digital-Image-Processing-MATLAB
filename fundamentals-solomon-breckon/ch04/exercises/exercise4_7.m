image = imread('cameraman.tif');

imshow(image);
title('Select ROI');
roi = roipoly;

k_gaussian = fspecial('gaussian', [5 5], 2);

k_mean = fspecial('average', [3 3]);

image_gaussian_filtered = roifilt2(k_gaussian, image, roi);

image_mean_filtered = roifilt2(k_mean, image, roi);

subplot(1, 3, 1);
imshow(image);
title('Original Image');

subplot(1, 3, 2);
imshow(image_gaussian_filtered);
title('Gaussian Filtered Image');

subplot(1, 3, 3);
imshow(image_mean_filtered);
title('Mean Filtered Image');
