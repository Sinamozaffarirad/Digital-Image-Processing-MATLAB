image = imread('peppers.png');
image = rgb2gray(image); 

neighborhoods = 1:2:21; 

minTimes = zeros(size(neighborhoods));
maxTimes = zeros(size(neighborhoods));
meanTimes = zeros(size(neighborhoods));

for i = 1:length(neighborhoods)
    N = neighborhoods(i);
    tic;
    minFiltered = nlfilter(image, [N N], @(x) min(x(:)));
    minTimes(i) = toc;
    
    tic;
    maxFiltered = nlfilter(image, [N N], @(x) max(x(:)));
    maxTimes(i) = toc;
    
    tic;
    meanFiltered = nlfilter(image, [N N], @(x) mean(x(:)));
    meanTimes(i) = toc;
end

% Plot neighborhood dimension vs run-time
figure;
plot(neighborhoods, minTimes, '-o', 'DisplayName', 'Min Filter');
hold on;
plot(neighborhoods, maxTimes, '-o', 'DisplayName', 'Max Filter');
plot(neighborhoods, meanTimes, '-o', 'DisplayName', 'Mean Filter');
xlabel('Neighborhood Dimension N');
ylabel('Operation Run-Time (seconds)');
title('Neighborhood Dimension vs Operation Run-Time');
legend show;
grid on;
