cameraman = imread('cameraman.tif');
circles = imread('circles.png');

circles_uint8 = uint8(circles);

concatenated_image = horzcat(cameraman, circles_uint8);

figure;
imshow(concatenated_image);
title('Concatenated Image');

figure;
imagesc(concatenated_image);
colormap gray;
title('Concatenated Image using imagesc');

C = 15; 
log_transformed = C * log(1 + double(concatenated_image));

log_transformed = uint8(255 * mat2gray(log_transformed));

figure;
imshow(log_transformed);
title('Logarithmic Transform Image');

hist_eq_image = histeq(concatenated_image);

figure;
imshow(hist_eq_image);
title('Histogram Equalized Image');

adapt_hist_eq_image = adapthisteq(concatenated_image);

figure;
imshow(adapt_hist_eq_image);
title('Adaptive Histogram Equalized Image');
