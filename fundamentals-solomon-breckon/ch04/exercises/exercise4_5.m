img = imread('cameraman.tif');

neighborhood_sizes = 0:25;

scales = [0.5, 1, 2]; 

num_iterations = 5;

times_scaled = zeros(length(scales), length(neighborhood_sizes));

for sIdx = 1:length(scales)
    scale = scales(sIdx);
    img_resized = imresize(img, scale);
    
    for nIdx = 1:length(neighborhood_sizes)
        neighborhood_size = neighborhood_sizes(nIdx);
        
        if neighborhood_size == 0
            times_scaled(sIdx, nIdx) = 0;
            continue;
        end
        
        neighborhood = [neighborhood_size, neighborhood_size];
        
        k = ones(neighborhood) / (neighborhood_size * neighborhood_size);
        
        total_time = 0;
        for iter = 1:num_iterations
            tic;
            imfilter(img_resized, k);
            total_time = total_time + toc;
        end
        
        times_scaled(sIdx, nIdx) = total_time / num_iterations;
    end
end

figure;
for sIdx = 1:length(scales)
    subplot(length(scales), 1, sIdx);
    plot(neighborhood_sizes, times_scaled(sIdx, :), '-o');
    title(sprintf('Execution Time for Mean Filtering (Scale: %.1f)', scales(sIdx)));
    xlabel('Neighborhood Size');
    ylabel('Time (seconds)');
    grid on;
end
