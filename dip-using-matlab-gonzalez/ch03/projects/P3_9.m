% Neighborhood size
m = 3;
n = 3;

% (a) Implement a nonlinear min filter using colfilt
% Applying the min filter using colfilt
f = imread('dentalXray-salt-noise.tif'); % Replace with the correct path to the image
g_min_filtered = colfilt(f, [m n], 'sliding', @(x) min(x, [], 1));
g_min_filtered = reshape(g_min_filtered, size(f)); % Reshape the result to the image size
figure, imshow(g_min_filtered), title('Min Filtered Image (a & b)');
% (b) Reading the image and applying the min filter
% (Already completed in part (a))

% (d) Showing better results using the median filter from the toolbox
g_median_filtered = medfilt2(f, [m n]);
figure, imshow(g_median_filtered), title('Median Filtered Image (d)');

% Explanation for (d): The median filter preserves edges better and is more effective at removing 'salt and pepper' noise.

% (c) Repeating the process using ordfilt2 for comparison
% Using ordfilt2 to perform median filtering (middle value of 3x3 is 5th in sorted list)
g_ordfilt2 = ordfilt2(f, 5, ones(m, n));
figure, imshow(g_ordfilt2), title('ordfilt2 Median Image (c)');

% There should be no significant differences between (c) and (d) results since both perform median filtering.
