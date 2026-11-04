image = imread('peppers.png');

k = fspecial('motion', 50, 45);

tic;
filtered_symmetric = imfilter(image, k, 'symmetric');
time_symmetric = toc;

tic;
filtered_replicate = imfilter(image, k, 'replicate');
time_replicate = toc;

tic;
filtered_circular = imfilter(image, k, 'circular');
time_circular = toc;

figure;

subplot(2, 2, 1);
imshow(image);
title('Original Image');

subplot(2, 2, 2);
imshow(filtered_symmetric);
title(['Symmetric Boundary, Time: ', num2str(time_symmetric), ' sec']);

subplot(2, 2, 3);
imshow(filtered_replicate);
title(['Replicate Boundary, Time: ', num2str(time_replicate), ' sec']);

subplot(2, 2, 4);
imshow(filtered_circular);
title(['Circular Boundary, Time: ', num2str(time_circular), ' sec']);
