%Exmaple3.1
A = imread('cameraman.tif');
subplot(1,2,1), imshow(A);
B = imadd(A, 100);
subplot(1,2,2), imshow(B);

%------------------------------------
%Exmaple3.2
A = imread("ch3_images\cola1.png");
B = imread("ch3_images\cola2.png");
subplot(1,3,1), imshow(A);
subplot(1,3,2), imshow(B);
Output = imsubtract(A, B);
subplot(1,3,3), imshow(Output);

%------------------------------------
%Example3.3
Output = imabsdiff(A, B);
imshow(Output);
%imagesc(Output, [10,100]);

%------------------------------------
%Example3.4
%imhist(A);
subplot(1,3,1), imshow(A);
Output1 = immultiply(A,1.5);
%imhist(Output1);
subplot(1,3,2), imshow(Output1);
Output2 = imdivide(A,4);
subplot(1,3,3), imshow(Output2);
%imhist(Output2);

%-------------------------------------
%Example3.5
A = imread('cameraman.tif'); 
subplot(1,2,1), imshow(A); 
B = imcomplement(A); 
subplot(1,2,2), imshow(B); 

%-------------------------------------
%Example3.6
A=imread('ch3_images\toycars1.png'); 
B=imread('ch3_images\toycars2.png'); 
Abw=im2bw(A);  
Bbw=im2bw(B);    
subplot(1,3,1), imshow(Abw); 
subplot(1,3,2), imshow(Bbw); 
Output = xor(Abw, Bbw); 
subplot(1,3,3), imshow(Output);

%-------------------------------------
%Example3.7
I=imread('trees.tif');
T=im2bw(I, 0.1); 
subplot(1,2,1), imshow(I); 
subplot(1,2,2), imshow(T); 

