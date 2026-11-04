rgb_image = imread('peppers.png');

g = fspecial('gaussian', [5 5], 1.5);

R = rgb_image(:, :, 1);
G = rgb_image(:, :, 2);
B = rgb_image(:, :, 3);

R_smoothed = imfilter(R, g, 'replicate');
G_smoothed = imfilter(G, g, 'replicate');
B_smoothed = imfilter(B, g, 'replicate');

R_diff = R - R_smoothed;
G_diff = G - G_smoothed;
B_diff = B - B_smoothed;

k_values = [0.3, 0.5, 0.7, 2.0];
num_k = length(k_values);

figure;

for i = 1:num_k
    k = k_values(i);
    
    R_sharpened = R + k * R_diff;
    G_sharpened = G + k * G_diff;
    B_sharpened = B + k * B_diff;
    
    rgb_sharpened = cat(3, R_sharpened, G_sharpened, B_sharpened);
    
    subplot(2, num_k, i);
    imshow(rgb_sharpened);
    title(['Unsharp k = ', num2str(k)]);
end

R_roberts = edge(R, 'roberts');
G_roberts = edge(G, 'roberts');
B_roberts = edge(B, 'roberts');
rgb_roberts = cat(3, uint8(R_roberts) * 255, uint8(G_roberts) * 255, uint8(B_roberts) * 255);

R_sobel = edge(R, 'sobel');
G_sobel = edge(G, 'sobel');
B_sobel = edge(B, 'sobel');
rgb_sobel = cat(3, uint8(R_sobel) * 255, uint8(G_sobel) * 255, uint8(B_sobel) * 255);

figure;
subplot(1, 2, 1);
imshow(rgb_roberts);
title('Roberts Edge Detection');

subplot(1, 2, 2);
imshow(rgb_sobel);
title('Sobel Edge Detection');

figure;
h = fspecial('unsharp');

R_unsharp = imfilter(R, h, 'replicate');
G_unsharp = imfilter(G, h, 'replicate');
B_unsharp = imfilter(B, h, 'replicate');

rgb_unsharp = cat(3, R_unsharp, G_unsharp, B_unsharp);

imshow(rgb_unsharp);
title('Unsharp Mask using fspecial');
