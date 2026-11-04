%7.1
load procrustes_star.mat;                                   %load coordinates of two shapes
whos                                                        %input_points and base_points
subplot(1,2,1),
plot(base_points(:,1),base_points(:,2),'kd'); hold on;      %Plot the shape coordinates
plot(input_points(:,1),input_points(:,2),'ro'); axis square; grid on
[D,Z,transform]=procrustes(input_points,base_points);       %Procrustes align input to base
subplot(1,2,2),
plot(input_points(:,1),input_points(:,2),'kd'); hold on;
plot(Z(:,1),Z(:,2),'ro'); axis square; grid on; hold off;	%Plot aligned coordinates
clear;                                   %Clear variables 
A = imread('plate_side.jpg');            %Read image to be registered
figure, imshow(A);                       %Display
[x,y]=ginput(4); input_points=[x y];     %Interactively define coords 
                                         %of input quadrilateral
figure, imshow('plate_reference.jpg')    %Read base reference)image.
[x,y]=ginput(4); base_points=[x y];      %Interactively define coords             
                                         %of base quadrilateral
t_carplate = cp2tform(input_points,base_points,'projective');    
                                         %Create projective  
                                         %transformation structure.
registered = imtransform(A,t_carplate);  %Apply projective transform 
B=imcrop(registered);                    %Interactively crop result
figure, imshow(B)                        %Display corrected image

%7.2
clear;                                   %Clear variables 
A = imread('plate_side.jpg');            %Read image to be registered
figure, imshow(A);                       %Display
[x,y]=ginput(4); input_points=[x y];     %Interactively define coords 
                                         %of input quadrilateral
figure, imshow('plate_reference.jpg')    %Read base reference)image.
[x,y]=ginput(4); base_points=[x y];      %Interactively define coords             
                                         %of base quadrilateral
t_carplate = cp2tform(input_points,base_points,'projective');    
                                         %Create projective  
                                         %transformation structure.
registered = imtransform(A,t_carplate);  %Apply projective transform 
B=imcrop(registered);                    %Interactively crop result
figure, imshow(B)                        %Display corrected image


%7.3
I = checkerboard(20,4);                             %Read in image
%I = imread('trui.png');                    		%Repeat afterwards for this image
[nrows,ncols] = size(I);                    		%Extract no. of cols and rows
[xi,yi] = meshgrid(1:ncols,1:nrows);        		%Define grid

imid = round(size(I,2)/2);                  		% Find index of middle element
xt = xi(:) - imid;                          		%Subtract off and thus
yt = yi(:) - imid;                          		%shift origin to centre
[theta,r] = cart2pol(xt,yt);                		%Convert from cartesian to polar
a = .0005;                                  		%Set the amplitude of the cubic term.
s = r + a.*r.^3;                             		%calculate BARREL distortion 
[ut,vt] = pol2cart(theta,s);               		 	%Return the (distorted)cartesian coordinates
u = reshape(ut,size(xi)) + imid;            		%reshape the coordinates to original 2-D grid  
v = reshape(vt,size(yi)) + imid;                    %reshape the coordinates into original 2-D grid 
tmap_B = cat(3,u,v);                        		%Assign u and v grids as the 2 planes of a 3-D array
resamp = makeresampler('linear','fill');    
I_barrel = tformarray(I,[],resamp,[2 1],[1 2],[],tmap_B,.3);


[theta,r] = cart2pol(xt,yt);                		%Convert from cartesian to polar
a=-0.000015;                                  		%Set amplitude of cubic term
s = r + a.*r.^3;                            		%calculate PINCUSHION distortion 
[ut,vt] = pol2cart(theta,s);                		%Return the (distorted)cartesian coordinates
u = reshape(ut,size(xi)) + imid;                    %reshape the coordinates into original 2-D grid  
v = reshape(vt,size(yi)) + imid;                    %reshape the coordinates into original 2-D grid 
tmap_B = cat(3,u,v);                        		%Assign u and v grids as the 2 planes of a 3-D array
resamp = makeresampler('linear','fill');            %Define resampling structure for use with tformarray
I_pin = tformarray(I,[],resamp,[2 1],[1 2],[],tmap_B,.3);
                                            		%Transform image to conform to grid in tmap_B                                            
subplot(131); imshow(I); 	subplot(1,3,2), imshow(I_barrel); 
subplot(1,3,3), imshow(I_pin); 
%7.4
I=imread('cameraman.tif');                          %Read in image
cpstruct=cpselect(I,I);                             %Mark the tie points and save within gui
                                                    %Gives input_points and output_points
tform=cp2tform(input_points,base_points,'affine');  %Infer affine transformation from tie points
B=imtransform(I,tform);                             %Transform input
subplot(1,2,1), imshow(I),subplot(1,2,2), imshow(B)	%Display
%7.5
load ('c:/chris/warp/ripollbabes.mat')                  %Load images and control point structure
cpselect(rgb2gray(A),rgb2gray(B),cpstruct);         	%Load up the tie points
tform=cp2tform(input_points,base_points,'polynomial');  
                                                        %Infer affine transformation from tie points
C=imtransform(A,tform);                                 %Transform input
subplot(1,2,1), imshow(I),subplot(1,2,2), imshow(C)     %Display
