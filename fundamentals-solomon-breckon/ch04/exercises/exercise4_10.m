rgb_image = imread('peppers.png');

R = rgb_image(:, :, 1);
G = rgb_image(:, :, 2);
B = rgb_image(:, :, 3);

R_roberts = edge(R, 'roberts');
G_roberts = edge(G, 'roberts');
B_roberts = edge(B, 'roberts');

R_roberts = uint8(R_roberts) * 255;
G_roberts = uint8(G_roberts) * 255;
B_roberts = uint8(B_roberts) * 255;

rgb_roberts = cat(3, R_roberts, G_roberts, B_roberts);

R_sobel = edge(R, 'sobel');
G_sobel = edge(G, 'sobel');
B_sobel = edge(B, 'sobel');

R_sobel = uint8(R_sobel) * 255;
G_sobel = uint8(G_sobel) * 255;
B_sobel = uint8(B_sobel) * 255;

rgb_sobel = cat(3, R_sobel, G_sobel, B_sobel);

hsv_image = rgb2hsv(rgb_image);

H = hsv_image(:, :, 1);
S = hsv_image(:, :, 2);
V = hsv_image(:, :, 3);

H_roberts = edge(H, 'roberts');
S_roberts = edge(S, 'roberts');
V_roberts = edge(V, 'roberts');

hsv_roberts = cat(3, H_roberts, S_roberts, V_roberts);

H_sobel = edge(H, 'sobel');
S_sobel = edge(S, 'sobel');
V_sobel = edge(V, 'sobel');

hsv_sobel = cat(3, H_sobel, S_sobel, V_sobel);

figure;

subplot(3, 3, 1);
imshow(rgb_image);
title('Original RGB Image');

subplot(3, 3, 2);
imshow(rgb_roberts);
title('Roberts Edge Detection (RGB)');

subplot(3, 3, 3);
imshow(rgb_sobel);
title('Sobel Edge Detection (RGB)');

subplot(3, 3, 4);
imshow(R_roberts);
title('Roberts - Red Channel');

subplot(3, 3, 5);
imshow(G_roberts);
title('Roberts - Green Channel');

subplot(3, 3, 6);
imshow(B_roberts);
title('Roberts - Blue Channel');

subplot(3, 3, 7);
imshow(R_sobel);
title('Sobel - Red Channel');

subplot(3, 3, 8);
imshow(G_sobel);
title('Sobel - Green Channel');

subplot(3, 3, 9);
imshow(B_sobel);
title('Sobel - Blue Channel');

figure;

subplot(3, 3, 1);
imshow(hsv2rgb(hsv_image));
title('Original HSV Image');

subplot(3, 3, 2);
imshow(hsv2rgb(hsv_roberts));
title('Roberts Edge Detection (HSV)');

subplot(3, 3, 3);
imshow(hsv2rgb(hsv_sobel));
title('Sobel Edge Detection (HSV)');

subplot(3, 3, 4);
imshow(H_roberts);
title('Roberts - Hue Channel');

subplot(3, 3, 5);
imshow(S_roberts);
title('Roberts - Saturation Channel');

subplot(3, 3, 6);
imshow(V_roberts);
title('Roberts - Value Channel');

subplot(3, 3, 7);
imshow(H_sobel);
title('Sobel - Hue Channel');

subplot(3, 3, 8);
imshow(S_sobel);
title('Sobel - Saturation Channel');

subplot(3, 3, 9);
imshow(V_sobel);
title('Sobel - Value Channel');
