original_image_path = 'input.tif'; 
enhanced_image = histogram_specification(original_image_path);

function enhanced_image = histogram_specification(original_image_path)
    % Original image
    original_image = imread(original_image_path); 
    % Converting the image to grayscale if it is RGB
    if size(original_image, 3) == 3
        original_image = rgb2gray(original_image);
    end    
    % Calculating the histogram and CDF of the original image
    [hist_original, ~] = imhist(original_image);
    cdf_original = cumsum(hist_original) / sum(hist_original);
    % Defining a target histogram shape manually
    target_hist = [linspace(1, 1000, 128), linspace(1000, 1, 128)]';
    target_hist = target_hist / sum(target_hist) * numel(original_image);
    cdf_target = cumsum(target_hist) / sum(target_hist);
    
    % Creating the mapping from the original to the target histogram
    map = zeros(256,1);
    for idx = 1:256
        [~, ind] = min(abs(cdf_original(idx) - cdf_target));
        map(idx) = ind - 1;
    end    
    % Applying the mapping to get the enhanced image
    enhanced_image = uint8(map(double(original_image) + 1));   
    % Displaying the images
    figure;
    subplot(1,2,1), imshow(original_image), title('Original Image');
    subplot(1,2,2), imshow(enhanced_image), title('Enhanced Image');
end
