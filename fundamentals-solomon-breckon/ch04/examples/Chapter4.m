%4.1
A=imread('cameraman.tif'); 
subplot(1,2,1), imshow(A); 
func=@(x) max(x(:)); 
B=nlfilter(A,[3 3],func); 
subplot(1,2,2), imshow(B);
%4.2
A=imread('peppers.png'); 
subplot(1,2,1), imshow(A);
k=fspecial('motion', 50, 54); 
B=imfilter(A, k, 'symmetric'); 
subplot(1,2,2), imshow(B);
%4.3
I=imread('eight.tif'); 
subplot(1,3,1), imshow(I); 
Isp=imnoise(I,'salt & pepper',0.03); 
subplot(1,3,2), imshow(Isp); 
Ig=imnoise(I,'gaussian',0.02);
subplot(1,3,3), imshow(Ig);
%4.4
k=ones(3,3)/9; 
Im=imfilter(I,k); 
Ispm=imfilter(Isp,k); 
Igm=imfilter(Ig,k);
subplot(1,3,1), imshow(Im);
subplot(1,3,2), imshow(Ispm);
subplot(1,3,3), imshow(Igm);
%4.5
Im=medfilt2(I,[3 3]);
Ispm=medfilt2(Isp,[3 3]); 
Igm=medfilt2(Ig,[3 3]); 
subplot(1,3,1), imshow(Im);
subplot(1,3,2), imshow(Ispm); 
subplot(1,3,3), imshow(Igm);
%4.6
Im=ordfilt2(I,25,ones(5,5)); 
Ispm=ordfilt2(Isp,25,ones(5,5)); 
Igm=ordfilt2(Ig,25,ones(5,5)); 
subplot(1,3,1), imshow(Im); 
subplot(1,3,2), imshow(Ispm); 
subplot(1,3,3), imshow(Igm);
%4.7
k=fspecial('gaussian', [5 5], 2); 
Ig=imfilter(I,k); 
Ispg=imfilter(Isp,k); 
Igg=imfilter(Ig,k);
subplot(1,3,1), imshow(Ig);
subplot(1,3,2), imshow(Ispg); 
subplot(1,3,3), imshow(Igg);
%4.8
I=imread('circuit.tif'); 
IEr=edge(I,'roberts');
IEp=edge(I,'prewitt'); 
IEs=edge(I,'sobel'); 
subplot(2,2,1), imshow(I); 
subplot(2,2,2), imshow(IEr); 
subplot(2,2,3), imshow(IEp);
subplot(2,2,4), imshow(IEs);
%4.9
I=rgb2gray(imread('peppers.png')); 
k=fspecial('laplacian'); 
IEl=imfilter(double(I),k,'symmetric'); 
subplot(1,2,1), imagesc(I); 
subplot(1,2,2), imagesc(IEl);
colormap('gray');
%4.10
I=rgb2gray(imread('peppers.png'));
k=fspecial('log', [10 10], 3.0); 
IEzc=edge(I, 'zerocross', [], k); 
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(IEzc);
%4.11
A=imread('cameraman.tif'); 
alpha = 0.2;
h=fspecial('laplacian', alpha); 
B=imfilter(A,h); 
C=imsubtract(A,B); 
subplot(1,3,1), imshow(A);
subplot(1,3,2), imagesc(B); axis image; axis off;
subplot(1,3,3), imshow(C);
%4.12
A=imread('cameraman.tif'); 
Iorig=imread('cameraman.tif');
g=fspecial('gaussian',[5 5],1.5);
subplot(2,3,1), imshow(Iorig); 
Is=imfilter(Iorig,g); 
Ie=(Iorig-Is); 
subplot(2,3,2), imshow(Ie); 

Iout=Iorig +(0.3).*Ie; 
subplot(2,3,3), imshow(Iout);
Iout=Iorig +(0.5).*Ie; 
subplot(2,3,4), imshow(Iout);
Iout=Iorig +(0.7).*Ie; 
subplot(2,3,5), imshow(Iout);
Iout=Iorig +(2.0).*Ie;
subplot(2,3,6), imshow(Iout);
