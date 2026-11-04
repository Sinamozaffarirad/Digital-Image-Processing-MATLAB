img = imread('cameraman.tif');

neighborhood_sizes = 1:25;

num_iterations = 5;

times_mean = zeros(1, length(neighborhood_sizes));
times_median = zeros(1, length(neighborhood_sizes));

for nIdx = 1:length(neighborhood_sizes)
    neighborhood_size = neighborhood_sizes(nIdx);
    
    neighborhood = [neighborhood_size, neighborhood_size];
    
    mean_filter = ones(neighborhood) / (neighborhood_size * neighborhood_size);
    
    total_time_mean = 0;
    for iter = 1:num_iterations
        tic;
        imfilter(img, mean_filter);
        total_time_mean = total_time_mean + toc;
    end
    times_mean(nIdx) = total_time_mean / num_iterations;
    
    total_time_median = 0;
    for iter = 1:num_iterations
        tic;
        medfilt2(img, neighborhood);
        total_time_median = total_time_median + toc;
    end
    times_median(nIdx) = total_time_median / num_iterations;
end

figure;
plot(neighborhood_sizes, times_mean, '-o', 'DisplayName', 'Mean Filtering');
hold on;
plot(neighborhood_sizes, times_median, '-x', 'DisplayName', 'Median Filtering');
hold off;
title('Execution Time for Mean vs Median Filtering');
xlabel('Neighborhood Size');
ylabel('Time (seconds)');
legend show;
grid on;
