% Function to perform thresholding on multiple images
function exercise3_5()
    % List of images to process
    images = {'pillsetc.png', 'tape.png', 'coins.png', 'eight.tif'};
    
    % Manual threshold value
    manual_threshold = 0.5;
    
    % Loop through each image
    for i = 1:length(images)
        % Load the image
        I = imread(images{i});

        % Convert to grayscale if necessary
        if size(I, 3) == 3
            I = rgb2gray(I);
        end

        % Perform manual thresholding
        T_manual = imbinarize(I, manual_threshold);

        % Perform adaptive thresholding using Example 3.15
        Im = imfilter(I, fspecial('average', [15 15]), 'replicate');
        It = I - Im + 20; % Add a constant to prevent negative values
        T_adaptive = imbinarize(It);

        % Perform median filtering and adaptive thresholding using Example 3.16
        N = 15; % Filter size
        Im_median = medfilt2(I, [N N]);
        It_median = I - Im_median + 20; % Add a constant to prevent negative values
        T_median = imbinarize(It_median);

        % Display the original and thresholded images
        figure;
        subplot(2, 2, 1);
        imshow(I);
        title(['Original Image - ', images{i}]);

        subplot(2, 2, 2);
        imshow(T_manual);
        title(['Manual Thresholded Image (Threshold = ', num2str(manual_threshold), ')']);

        subplot(2, 2, 3);
        imshow(T_adaptive);
        title('Adaptive Thresholded Image (Example 3.15)');

        subplot(2, 2, 4);
        imshow(T_median);
        title('Median Filtered & Adaptive Thresholded Image (Example 3.16)');
    end
end

