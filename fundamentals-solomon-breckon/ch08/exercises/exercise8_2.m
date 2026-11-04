I = [
    0 0 0 0 0 0 0;
    0 1 1 1 0 0 0;
    0 1 1 1 1 0 0;
    0 0 1 1 1 1 0;
    0 0 0 1 1 0 0;
    0 0 0 0 0 0 0;
    0 0 0 0 0 0 0;
];

SE_small = [
    1 1;
    1 1;
];

eroded_image_small = imerode(I, SE_small);
closed_image_small = imdilate(eroded_image_small, SE_small);

dilated_image_small = imdilate(I, SE_small);
opened_image_small = imerode(dilated_image_small, SE_small);

figure;
subplot(1, 3, 1);
imshow(I, []);
title('Original Image');

subplot(1, 3, 2);
imshow(closed_image_small, []);
title('Closed Image (Smaller SE)');

subplot(1, 3, 3);
imshow(opened_image_small, []);
title('Opened Image (Smaller SE)');
