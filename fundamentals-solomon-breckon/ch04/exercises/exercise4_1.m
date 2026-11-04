colorImage = imread('peppers.png');
grayImage = imread('eight.tif');

% Add different levels of 'salt and pepper' noise
spNoiseLevel1 = imnoise(colorImage, 'salt & pepper', 0.02);
spNoiseLevel2 = imnoise(colorImage, 'salt & pepper', 0.05);
spNoiseLevel3 = imnoise(grayImage, 'salt & pepper', 0.02);
spNoiseLevel4 = imnoise(grayImage, 'salt & pepper', 0.05);

% Add different levels of Gaussian noise
gaussNoiseLevel1 = imnoise(colorImage, 'gaussian', 0, 0.01);
gaussNoiseLevel2 = imnoise(colorImage, 'gaussian', 0, 0.05);
gaussNoiseLevel3 = imnoise(grayImage, 'gaussian', 0, 0.01);
gaussNoiseLevel4 = imnoise(grayImage, 'gaussian', 0, 0.05);

% Apply mean filtering
meanFilter = fspecial('average', [3 3]);
meanFilteredSP1 = imfilter(spNoiseLevel1, meanFilter);
meanFilteredSP2 = imfilter(spNoiseLevel2, meanFilter);
meanFilteredGauss1 = imfilter(gaussNoiseLevel1, meanFilter);
meanFilteredGauss2 = imfilter(gaussNoiseLevel2, meanFilter);

% Apply median filtering
medianFilteredSP1 = medfilt2(spNoiseLevel3);
medianFilteredSP2 = medfilt2(spNoiseLevel4);
medianFilteredGauss1 = medfilt2(gaussNoiseLevel3);
medianFilteredGauss2 = medfilt2(gaussNoiseLevel4);

% Apply Gaussian filtering
gaussianFilter = fspecial('gaussian', [3 3], 0.5);
gaussianFilteredSP1 = imfilter(spNoiseLevel1, gaussianFilter);
gaussianFilteredSP2 = imfilter(spNoiseLevel2, gaussianFilter);
gaussianFilteredGauss1 = imfilter(gaussNoiseLevel1, gaussianFilter);
gaussianFilteredGauss2 = imfilter(gaussNoiseLevel2, gaussianFilter);

figure;
subplot(3, 4, 1), imshow(spNoiseLevel1), title('SP Noise Level 0.02');
subplot(3, 4, 2), imshow(meanFilteredSP1), title('Mean Filtered SP 0.02');
subplot(3, 4, 3), imshow(medianFilteredSP1), title('Median Filtered SP 0.02');
subplot(3, 4, 4), imshow(gaussianFilteredSP1), title('Gaussian Filtered SP 0.02');
subplot(3, 4, 5), imshow(spNoiseLevel2), title('SP Noise Level 0.05');
subplot(3, 4, 6), imshow(meanFilteredSP2), title('Mean Filtered SP 0.05');
subplot(3, 4, 7), imshow(medianFilteredSP2), title('Median Filtered SP 0.05');
subplot(3, 4, 8), imshow(gaussianFilteredSP2), title('Gaussian Filtered SP 0.05');
subplot(3, 4, 9), imshow(gaussNoiseLevel1), title('Gaussian Noise Level 0.01');
subplot(3, 4, 10), imshow(meanFilteredGauss1), title('Mean Filtered Gauss 0.01');
subplot(3, 4, 11), imshow(medianFilteredGauss1), title('Median Filtered Gauss 0.01');
subplot(3, 4, 12), imshow(gaussianFilteredGauss1), title('Gaussian Filtered Gauss 0.01');

figure;
subplot(3, 4, 1), imshow(gaussNoiseLevel2), title('Gaussian Noise Level 0.05');
subplot(3, 4, 2), imshow(meanFilteredGauss2), title('Mean Filtered Gauss 0.05');
subplot(3, 4, 3), imshow(medianFilteredGauss2), title('Median Filtered Gauss 0.05');
subplot(3, 4, 4), imshow(gaussianFilteredGauss2), title('Gaussian Filtered Gauss 0.05');
subplot(3, 4, 5), imshow(spNoiseLevel3), title('SP Noise Level 0.02 (Gray)');
subplot(3, 4, 6), imshow(meanFilteredSP1), title('Mean Filtered SP 0.02 (Gray)');
subplot(3, 4, 7), imshow(medianFilteredSP1), title('Median Filtered SP 0.02 (Gray)');
subplot(3, 4, 8), imshow(gaussianFilteredSP1), title('Gaussian Filtered SP 0.02 (Gray)');
subplot(3, 4, 9), imshow(spNoiseLevel4), title('SP Noise Level 0.05 (Gray)');
subplot(3, 4, 10), imshow(meanFilteredSP2), title('Mean Filtered SP 0.05 (Gray)');
subplot(3, 4, 11), imshow(medianFilteredSP2), title('Median Filtered SP 0.05 (Gray)');
subplot(3, 4, 12), imshow(gaussianFilteredSP2), title('Gaussian Filtered SP 0.05 (Gray)');
