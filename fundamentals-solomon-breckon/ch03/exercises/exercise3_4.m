A = imread('peppers.png'); 
B = imread('AT3_1m4_09.tif'); 

A = imresize(A, [size(B, 1), size(B, 2)]);

A = im2double(A);
B = im2double(B);

if size(A, 3) ~= size(B, 3)
    if size(A, 3) == 1
        A = repmat(A, [1 1 3]);
    else
        B = repmat(B, [1 1 3]);
    end
end

wA = 0.5; % Weight for image A
wB = 0.5; % Weight for image B

blendedImage = imadd(immultiply(A, wA), immultiply(B, wB));

figure;
subplot(1, 3, 1);
imshow(A);
title('Image A');

subplot(1, 3, 2);
imshow(B);
title('Image B');

subplot(1, 3, 3);
imshow(blendedImage);
title('Blended Image');
