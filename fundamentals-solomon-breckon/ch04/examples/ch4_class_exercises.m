% Load example images
peppers_img = imread('peppers.png'); % Color image
eight_img = imread('eight.tif'); % Grayscale image

% Add different levels of 'salt and pepper' and Gaussian noise
noisy_peppers_sp = imnoise(peppers_img, 'salt & pepper', 0.02);
noisy_peppers_gaussian = imnoise(peppers_img, 'gaussian', 0, 0.01);
noisy_eight_sp = imnoise(eight_img, 'salt & pepper', 0.02);
noisy_eight_gaussian = imnoise(eight_img, 'gaussian', 0, 0.01);

% Apply mean, median, and Gaussian filtering
mean_filter = fspecial('average', [3, 3]);
gaussian_filter = fspecial('gaussian', [3, 3], 0.5);

% Function to apply median filter to each channel separately
apply_median_filter = @(img) cat(3, medfilt2(img(:,:,1), [3, 3]), medfilt2(img(:,:,2), [3, 3]), medfilt2(img(:,:,3), [3, 3]));

mean_filtered_peppers_sp = imfilter(noisy_peppers_sp, mean_filter);
median_filtered_peppers_sp = apply_median_filter(noisy_peppers_sp);
gaussian_filtered_peppers_sp = imfilter(noisy_peppers_sp, gaussian_filter);

mean_filtered_peppers_gaussian = imfilter(noisy_peppers_gaussian, mean_filter);
median_filtered_peppers_gaussian = apply_median_filter(noisy_peppers_gaussian);
gaussian_filtered_peppers_gaussian = imfilter(noisy_peppers_gaussian, gaussian_filter);

mean_filtered_eight_sp = imfilter(noisy_eight_sp, mean_filter);
median_filtered_eight_sp = medfilt2(noisy_eight_sp, [3, 3]);
gaussian_filtered_eight_sp = imfilter(noisy_eight_sp, gaussian_filter);

mean_filtered_eight_gaussian = imfilter(noisy_eight_gaussian, mean_filter);
median_filtered_eight_gaussian = medfilt2(noisy_eight_gaussian, [3, 3]);
gaussian_filtered_eight_gaussian = imfilter(noisy_eight_gaussian, gaussian_filter);

% Display results
figure;
subplot(2, 3, 1), imshow(noisy_peppers_sp), title('Noisy Peppers (S&P)');
subplot(2, 3, 2), imshow(mean_filtered_peppers_sp), title('Mean Filtered');
subplot(2, 3, 3), imshow(median_filtered_peppers_sp), title('Median Filtered');
subplot(2, 3, 4), imshow(noisy_peppers_gaussian), title('Noisy Peppers (Gaussian)');
subplot(2, 3, 5), imshow(mean_filtered_peppers_gaussian), title('Mean Filtered');
subplot(2, 3, 6), imshow(median_filtered_peppers_gaussian), title('Median Filtered');

figure;
subplot(2, 3, 1), imshow(noisy_eight_sp), title('Noisy Eight (S&P)');
subplot(2, 3, 2), imshow(mean_filtered_eight_sp), title('Mean Filtered');
subplot(2, 3, 3), imshow(median_filtered_eight_sp), title('Median Filtered');
subplot(2, 3, 4), imshow(noisy_eight_gaussian), title('Noisy Eight (Gaussian)');
subplot(2, 3, 5), imshow(mean_filtered_eight_gaussian), title('Mean Filtered');
subplot(2, 3, 6), imshow(median_filtered_eight_gaussian), title('Median Filtered');
%------------------------------------------------------
% Load example image
image = imread('cameraman.tif');

% Define neighborhood dimensions
neighborhood_sizes = 1:2:25;
operation_times = zeros(length(neighborhood_sizes), 3); % [min, max, mean]

% Measure operation run-time for different neighborhood dimensions
for i = 1:length(neighborhood_sizes)
    n = neighborhood_sizes(i);
    
    % Measure min() operation time
    tic;
    colfilt(image, [n n], 'sliding', @(x) min(x, [], 1));
    operation_times(i, 1) = toc;
    
    % Measure max() operation time
    tic;
    colfilt(image, [n n], 'sliding', @(x) max(x, [], 1));
    operation_times(i, 2) = toc;
    
    % Measure mean() operation time
    tic;
    colfilt(image, [n n], 'sliding', @(x) mean(x, 1));
    operation_times(i, 3) = toc;
end

% Plot results
figure;
plot(neighborhood_sizes, operation_times(:, 1), '-o', 'DisplayName', 'Min Operation');
hold on;
plot(neighborhood_sizes, operation_times(:, 2), '-o', 'DisplayName', 'Max Operation');
plot(neighborhood_sizes, operation_times(:, 3), '-o', 'DisplayName', 'Mean Operation');
hold off;
xlabel('Neighborhood Size (NxN)');
ylabel('Operation Time (seconds)');
legend;
title('Operation Time vs. Neighborhood Size');
%-------------------------------------------

