image = imread('peppers.png');
image = rgb2gray(image); 

x = 100; 
y = 100; 
N = 21; 
magnificationFactor = 5; 

extractedRegion = extractAndMagnify(image, x, y, N, magnificationFactor);

figure;
subplot(1, 2, 1);
imshow(image);
title('Original Image');
hold on;
rectangle('Position', [y - floor(N/2), x - floor(N/2), N, N], 'EdgeColor', 'r');

subplot(1, 2, 2);
imshow(extractedRegion);
title('Extracted and Magnified Region');