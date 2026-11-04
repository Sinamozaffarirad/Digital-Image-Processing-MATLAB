fileNames = {
    'AT3_1m4_01.tif', 'AT3_1m4_02.tif', 'AT3_1m4_03.tif', 'AT3_1m4_04.tif', ...
    'AT3_1m4_05.tif', 'AT3_1m4_06.tif', 'AT3_1m4_07.tif', 'AT3_1m4_08.tif', ...
    'AT3_1m4_09.tif', 'AT3_1m4_10.tif'
};

prevImage = imread(fileNames{1});

for k = 2:length(fileNames)
    currImage = imread(fileNames{k});
    
    diffImage = imabsdiff(prevImage, currImage);
    
    figure;
    imshow(diffImage, []);
    title(['Difference between Image ', num2str(k-1), ' and Image ', num2str(k)]);
    
    saveas(gcf, ['3.3.', num2str(k-1), '.jpg']);
    
    close(gcf);
    
    prevImage = currImage;
    
    pause(0.5);
end
