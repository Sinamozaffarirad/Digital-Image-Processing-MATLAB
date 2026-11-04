function extractedRegion = extractAndMagnify(image, x, y, N, magnificationFactor)
    % Extract the N x N neighborhood centered at (x, y)
    halfN = floor(N / 2);
    [rows, cols] = size(image);
    
    % Ensure the neighborhood is within the image bounds
    startRow = max(1, x - halfN);
    endRow = min(rows, x + halfN);
    startCol = max(1, y - halfN);
    endCol = min(cols, y + halfN);
    
    % Adjust the region size if it's smaller than N x N
    region = image(startRow:endRow, startCol:endCol);
    
    % Magnify the extracted region
    extractedRegion = imresize(region, magnificationFactor);
end