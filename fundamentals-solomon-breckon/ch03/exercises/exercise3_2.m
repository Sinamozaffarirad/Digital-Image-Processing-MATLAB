peppers = imread('peppers.png');
spine = imread('spine.tif');
cell = imread('AT3_1m4_09.tif');

peppers_inverted = imcomplement(peppers);
spine_inverted = imcomplement(spine);
cell_inverted = imcomplement(cell);

figure;

subplot(2, 2, 1);
imshow(peppers);
title('Original Peppers Image');

subplot(2, 2, 2);
imshow(peppers_inverted);
title('Inverted Peppers Image');

subplot(2, 2, 3);
imshow(spine);
title('Original Spine Image');

subplot(2, 2, 4);
imshow(spine_inverted);
title('Inverted Spine Image');

figure;

subplot(2, 2, 1);
imshow(cell);
title('Original Cell Image');

subplot(2, 2, 2);
imshow(cell_inverted);
title('Inverted Cell Image');
