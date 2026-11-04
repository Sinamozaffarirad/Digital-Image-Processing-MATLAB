I = [
    0 0 0 0 0 0 0;
    0 1 1 1 0 0 0;
    0 1 1 1 1 0 0;
    0 0 1 1 1 1 0;
    0 0 0 1 1 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
];

SE = [
    1 0 0;
    0 1 0;
    0 0 1;
];

eroded_image = imerode(I, SE);

dilated_image = imdilate(I, SE);

figure;
subplot(1, 3, 1);
imshow(I, []);
title('Original Image');

subplot(1, 3, 2);
imshow(eroded_image, []);
title('Eroded Image');

subplot(1, 3, 3);
imshow(dilated_image, []);
title('Dilated Image');
