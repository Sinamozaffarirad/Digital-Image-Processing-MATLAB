% Circle
radius = 80;
circle_image = false(500, 500);
[X, Y] = meshgrid(1:500, 1:500);
circle_image((X - 250).^2 + (Y - 250).^2 <= radius^2) = true;

% Square
square_image = false(500, 500);
square_image(200:300, 200:300) = true;

% Equilateral Triangle
triangle = polyshape([150 350 250], [400 400 150]);
triangle_image = poly2mask(triangle.Vertices(:,1), triangle.Vertices(:,2), 500, 500);

% Compute the skeletons
circle_skeleton = bwskel(circle_image);
square_skeleton = bwskel(square_image);
triangle_skeleton = bwskel(triangle_image);

% Display the original figures and their skeletons
figure;
subplot(3, 2, 1);
imshow(circle_image);
title('Original Circle');

subplot(3, 2, 2);
imshow(circle_skeleton);
title('Skeleton of Circle');

subplot(3, 2, 3);
imshow(square_image);
title('Original Square');

subplot(3, 2, 4);
imshow(square_skeleton);
title('Skeleton of Square');

subplot(3, 2, 5);
imshow(triangle_image);
title('Original Triangle');

subplot(3, 2, 6);
imshow(triangle_skeleton);
title('Skeleton of Triangle');
