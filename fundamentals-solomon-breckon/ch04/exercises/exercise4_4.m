img = imread('cameraman.tif');

neighborhood_sizes = [3, 5, 7, 9, 11, 15, 21, 31];

operations = {'min', 'max', 'mean'};
operation_funcs = {@min, @max, @mean};

results = struct;

for opIdx = 1:length(operations)
    operation = operations{opIdx};
    operation_func = operation_funcs{opIdx};
    results.(operation) = struct;
    
    for nIdx = 1:length(neighborhood_sizes)
        neighborhood_size = neighborhood_sizes(nIdx);
        neighborhood = [neighborhood_size, neighborhood_size];
        
        tic;
        colfilt(img, neighborhood, 'sliding', operation_func);
        time_with_opt = toc;
        
        tic;
        colfilt(img, neighborhood, 'sliding', operation);
        time_without_opt = toc;
        
        results.(operation).(sprintf('size_%d', neighborhood_size)) = ...
            struct('with_opt', time_with_opt, 'without_opt', time_without_opt);
    end
end

disp('Performance Results:');
disp(results);

figure;
for opIdx = 1:length(operations)
    operation = operations{opIdx};
    times_with_opt = [];
    times_without_opt = [];
    
    for nIdx = 1:length(neighborhood_sizes)
        neighborhood_size = neighborhood_sizes(nIdx);
        time_with_opt = results.(operation).(sprintf('size_%d', neighborhood_size)).with_opt;
        time_without_opt = results.(operation).(sprintf('size_%d', neighborhood_size)).without_opt;
        
        times_with_opt = [times_with_opt, time_with_opt];
        times_without_opt = [times_without_opt, time_without_opt];
    end
    
    subplot(length(operations), 1, opIdx);
    plot(neighborhood_sizes, times_with_opt, '-o', 'DisplayName', 'With Optimization');
    hold on;
    plot(neighborhood_sizes, times_without_opt, '-x', 'DisplayName', 'Without Optimization');
    hold off;
    title(sprintf('Operation: %s', operation));
    xlabel('Neighborhood Size');
    ylabel('Time (seconds)');
    legend show;
end
