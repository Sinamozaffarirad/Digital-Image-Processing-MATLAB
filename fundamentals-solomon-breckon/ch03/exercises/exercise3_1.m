image1 = imread('rice.png');
image2 = imread('cameraman.tif');

figure;
subplot(2,3,1);
imshow(image1);
title('Original Image 1 (rice.png)');

subplot(2,3,2);
imshow(image2);
title('Original Image 2 (cameraman.tif)');

image1_resized = imresize(image1, [size(image2, 1), size(image2, 2)]);

subplot(2,3,3);
imshow(image1_resized);
title('Resized Image 1');

whos image1 image2 image1_resized

image_add_plus = image1_resized + image2;

subplot(2,3,4);
imshow(image_add_plus, []);
title('Addition using "+"');

image_add_imadd = imadd(image1_resized, image2);

subplot(2,3,5);
imshow(image_add_imadd, []);
title('Addition using imadd');

image_subtract_minus = image1_resized - image2;

subplot(2,3,6);
imshow(image_subtract_minus, []);
title('Subtraction using "-"');

figure;
image_subtract_imsubtract = imsubtract(image1_resized, image2);

subplot(1,2,1);
imshow(image_subtract_imsubtract, []);
title('Subtraction using imsubtract');

image_abs_diff = imabsdiff(image1_resized, image2);

subplot(1,2,2);
imshow(image_abs_diff, []);
title('Absolute Difference using imabsdiff');
