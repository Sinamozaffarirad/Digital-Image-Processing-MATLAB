f = imread('input.tif');
g = histeq(f);  
imshow(g);
f = imread('input.tif');
tic;
ghisteq = localhisteq(f, 3, 3);
toc; 

tic;
gloops = localhisteq_loops(f, 3, 3);
toc;  

function g = localhisteq(f, m, n)
    if nargin < 3
        m = 3; n = 3;
    end
    f = im2double(f);   
    f_padded = padarray(f, [(m-1)/2 (n-1)/2], 'replicate', 'both');  
    g = zeros(size(f));  
    for i = 1:size(f,1)
        for j = 1:size(f,2)
            local_region = f_padded(i:i+m-1, j:j+n-1);
            
            local_hist = imhist(local_region(:));
            local_cdf = cumsum(local_hist) / sum(local_hist);
            g(i,j) = local_cdf(round(local_region((m+1)/2,(n+1)/2) * 255 + 1));
        end
    end
        g = im2uint8(g);
end

function g = localhisteq_loops(f, m, n)
    [rows, cols] = size(f);
    g = zeros(size(f), 'like', f);  
    padSize = floor([m n] / 2);
    fp = padarray(f, padSize, 'replicate', 'both');
    h = waitbar(0, 'Applying local histogram equalization...');
    for i = 1 + padSize(1):rows + padSize(1)
        for j = 1 + padSize(2):cols + padSize(2)
            localWindow = fp(i-padSize(1):i+padSize(1), j-padSize(2):j+padSize(2));
            local_hist = imhist(localWindow(:), 256);
            local_cdf = cumsum(local_hist) / sum(local_hist);
            local_cdf = local_cdf / local_cdf(end); 
            pixel_value = fp(i, j);
            new_pixel_value = local_cdf(pixel_value + 1) * 255;
            g(i - padSize(1), j - padSize(2)) = new_pixel_value;
        end
        waitbar((i - padSize(1)) / rows, h);
    end
    close(h);
end

