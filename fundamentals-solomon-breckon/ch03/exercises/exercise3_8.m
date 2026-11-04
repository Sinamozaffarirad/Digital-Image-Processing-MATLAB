I = imread('mandi.tif');

if size(I, 3) == 3
    I = rgb2gray(I);
end

figure;
imshow(I);
title('Original Image - mandi.tif');

C_log = 1;
log_transformed = C_log * log(1 + double(I));
log_transformed = uint8(255 * mat2gray(log_transformed)); 

figure;
imshow(log_transformed);
title('Logarithmic Transform Image');

C_exp = 1;
exp_transformed = C_exp * (exp(double(I)/255) - 1);
exp_transformed = uint8(255 * mat2gray(exp_transformed)); 

figure;
imshow(exp_transformed);
title('Exponential Transform Image');
