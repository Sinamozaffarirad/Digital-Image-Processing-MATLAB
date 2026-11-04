f = imread('chestXray-dark.tif');
% Enhancing the image using histogram equalization
g_a = histeq(f);
% Displaying the images
figure;
subplot(1, 2, 1), imshow(f), title('Original Image');
subplot(1, 2, 2), imshow(g_a), title('Histogram Equalized Image');
% Sharpenening the image first
sharpened_img = imsharpen(f);
% Then enhancing the sharpened image using histogram equalization
g_b = histeq(sharpened_img);
% Displaying the sharpened & Histogram Equalized images 
figure;
subplot(1, 2, 1), imshow(sharpened_img), title('Sharpened Image');
subplot(1, 2, 2), imshow(g_b), title('Sharpened & Histogram Equalized Image');
% Enhancing the original image using histogram equalization first
equalized_img = histeq(f);
% sharpening the histogram-equalized image
g_c = imsharpen(equalized_img);
% Display the images
figure;
subplot(1, 2, 1), imshow(equalized_img), title('Histogram Equalized Image');
subplot(1, 2, 2), imshow(g_c), title('Equalized & Sharpened Image');

% Difference between (b) and (c) :
% Sharpening after histogram equalization could result in amplified noise
% because equalization can increase the contrast of noise. When sharpening is
% applied first, the details are enhanced before the contrast is stretched, which
% might result in a more natural-looking enhancement with less noise amplification.