function exercise3_6()
    images = {'cameraman.tif', 'coins.png'};
    
    C_values = [0, 10, 20, 30, 40];
    
    figureCounter = 1;
    
    for i = 1:length(images)
        I = imread(images{i});

        if size(I, 3) == 3
            I = rgb2gray(I);
        end

        for j = 1:length(C_values)
            C = C_values(j);

            Im = imfilter(I, fspecial('average', [15 15]), 'replicate');
            It = I - Im + C;
            T_adaptive = imbinarize(It);

            figure;
            subplot(1, 2, 1);
            imshow(I);
            title(['Original Image - ', images{i}]);

            subplot(1, 2, 2);
            imshow(T_adaptive);
            title(['Adaptive Thresholded Image (C = ', num2str(C), ')']);

            saveas(gcf, ['3.6.', num2str(figureCounter), '.jpg']);
            close(gcf);
            figureCounter = figureCounter + 1;
        end
    end

    for i = 1:length(images)
        I = imread(images{i});

        if size(I, 3) == 3
            I = rgb2gray(I);
        end

        for j = 1:length(C_values)
            C = C_values(j);

            t = floor((max(I(:)) - min(I(:))) / 2) + C;
            T_third_method = I > t;

            figure;
            subplot(1, 2, 1);
            imshow(I);
            title(['Original Image - ', images{i}]);

            subplot(1, 2, 2);
            imshow(T_third_method);
            title(['Thresholded Image (t = ', num2str(t), ', C = ', num2str(C), ')']);

            saveas(gcf, ['3.6.', num2str(figureCounter), '.jpg']);
            close(gcf); 
            figureCounter = figureCounter + 1; 
        end
    end
end