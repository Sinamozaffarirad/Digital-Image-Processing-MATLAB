I = imread('eight.tif');

Isp = imnoise(I, 'salt & pepper', 0.03);
Ig = imnoise(I, 'gaussian', 0.02);

tic;
Isp_conservative = conservative_smoothing_filter(Isp);
time_conservative_sp = toc;

tic;
Ig_conservative = conservative_smoothing_filter(Ig);
time_conservative_g = toc;

mean_filter = fspecial('average', [3 3]);

tic;
Isp_mean = imfilter(Isp, mean_filter);
time_mean_sp = toc;

tic;
Ig_mean = imfilter(Ig, mean_filter);
time_mean_g = toc;

tic;
Isp_median = medfilt2(Isp, [3 3]);
time_median_sp = toc;

tic;
Ig_median = medfilt2(Ig, [3 3]);
time_median_g = toc;

figure;

subplot(3, 3, 1);
imshow(I);
title('Original Image');

subplot(3, 3, 2);
imshow(Isp);
title('Salt & Pepper Noise');

subplot(3, 3, 3);
imshow(Ig);
title('Gaussian Noise');

subplot(3, 3, 4);
imshow(Isp_conservative);
title(['Conservative Filter SP, Time: ', num2str(time_conservative_sp), ' sec']);

subplot(3, 3, 5);
imshow(Isp_mean);
title(['Mean Filter SP, Time: ', num2str(time_mean_sp), ' sec']);

subplot(3, 3, 6);
imshow(Isp_median);
title(['Median Filter SP, Time: ', num2str(time_median_sp), ' sec']);

subplot(3, 3, 7);
imshow(Ig_conservative);
title(['Conservative Filter G, Time: ', num2str(time_conservative_g), ' sec']);

subplot(3, 3, 8);
imshow(Ig_mean);
title(['Mean Filter G, Time: ', num2str(time_mean_g), ' sec']);

subplot(3, 3, 9);
imshow(Ig_median);
title(['Median Filter G, Time: ', num2str(time_median_g), ' sec']);


function output = conservative_smoothing_filter(input_image)
    [rows, cols] = size(input_image);
    
    output = input_image;
    
    for i = 2:rows-1
        for j = 2:cols-1
            neighborhood = input_image(i-1:i+1, j-1:j+1);
            
            mean_val = mean(neighborhood(:));
            
            if input_image(i, j) < mean_val
                output(i, j) = min(neighborhood(:));
            elseif input_image(i, j) > mean_val
                output(i, j) = max(neighborhood(:));
            end
        end
    end
end
