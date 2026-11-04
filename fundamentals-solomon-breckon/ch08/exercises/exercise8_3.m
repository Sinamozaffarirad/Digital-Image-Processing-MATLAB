I = imread('blobs.png');
figure;
imshow(I);
title('Original Image - blobs.png');

SE = [
    1 1 1 1 1;
    1 1 1 1 1;
    1 1 1 1 1;
    1 1 1 1 1;
    1 1 1 1 1;
];

eroded_image = imerode(I, SE);
figure;
imshow(eroded_image);
title('Eroded Image using direct SE');

SE_decomposed = strel('square', 5);

decomposed_eroded_image = imerode(I, SE_decomposed);
figure;
imshow(decomposed_eroded_image);
title('Eroded Image using decomposed SE');

is_equal = isequal(eroded_image, decomposed_eroded_image);
disp(['Are both eroded images the same? ', num2str(is_equal)]);
