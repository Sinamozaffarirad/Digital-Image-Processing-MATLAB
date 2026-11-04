f = imread('input.tif');
% Converting the image intensities to the range [0, 1] to simplify comparisons
f = im2double(f);
% Defining sigma
sigma = 5;
% The upper bound for kernel size is defined as 6*sigma. Since we want the
% kernel size to be odd, we round up to the nearest odd integer.
maxKernelSize = ceil(6 * sigma);
if mod(maxKernelSize, 2) == 0
    maxKernelSize = maxKernelSize + 1;
end
% Starting with a kernel size of 3 and incrementing by 2 to keep it odd
for kernelSize = 3:2:maxKernelSize
    % Applying Gaussian filter with current kernel size
    H = fspecial('gaussian', [kernelSize kernelSize], sigma);
    g = imfilter(f, H, 'replicate');
    
    % Calculating the maximum change at any point in the image from one kernel
    % size to the next
    if exist('g_previous', 'var')
        maxChange = max(abs(g(:) - g_previous(:)));
        fprintf('Kernel Size: %d, Maximum Change: %f\n', kernelSize, maxChange);
        
        % If the maximum change is less than one intensity level in 256, break the loop
        if maxChange < 1/256
            smallestKernelSize = kernelSize;
            break;
        end
    end
    % Storing the current filtered image for comparison in the next iteration
    g_previous = g;
end

% Displaying the size of the smallest square kernel for which the condition holds
fprintf('The size of the smallest square kernel for which the maximum change is less than one intensity level in 256 is: %d\n', smallestKernelSize);
