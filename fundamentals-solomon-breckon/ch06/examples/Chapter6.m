%6.1
A=imread('trui.png'); B=fft2(A); B=fftshift(B);		
[x y]=size(A); [X Y]=meshgrid(1:x,1:y); 		
h=exp(-(X-x/2).^2./48).*exp(-(Y-y/2).^2./48);		
H=psf2otf(h,size(h)); H=fftshift(H);               
g=ifft2(B.*H); g=abs(g);                           

G=fft2(g); G=fftshift(G);                      
indices=find(H>1e-6);                             
F=zeros(size(G)); F(indices)=G(indices)./H(indices);	
f=ifft2(F); f=abs(f);                             
subplot(1,4,1), imshow(g,[min(min(g)) max(max(g))]);
subplot(1,4,2), imagesc(h); axis square; axis off; colormap(gray);
subplot(1,4,3), imagesc(abs(H)); axis square; axis off; colormap(gray);
subplot(1,4,4), imshow(real(f),[]); 
%6.2
A=imread('trui.png'); B=fft2(A); B=fftshift(B);						
[x y]=size(A); [X Y]=meshgrid(1:x,1:y); 
h=exp(-(X-x/2).^2./48).*exp(-(Y-y/2).^2./48);	
H=psf2otf(h,size(h)); H=fftshift(H);		
g=ifft2(B.*H); g=mat2gray(abs(g));		
g=imnoise(g,'gaussian',0,0.002);			

G=fft2(g); G=fftshift(G);			
indices=find(H>1e-6); 					
F=zeros(size(G)); F(indices)=G(indices)./H(indices);	
f=ifft2(F); f=abs(f);					
subplot(1,4,1), imshow(g,[min(min(g)) max(max(g))]);	
subplot(1,4,2), imagesc(h); axis square; axis off;		
subplot(1,4,3), imagesc(abs(H)); axis square; axis off; 	
subplot(1,4,4), imagesc(f); axis square; axis tight; axis off; 
%6.3
I = imread('trui.png');I=double(I); 
noise=15.*randn(size(I));
PSF=fspecial('motion',21,11); 
Blurred=imfilter(I,PSF,'circular'); 
BlurredNoisy=Blurred + noise;

NSR=sum(noise(:).^2)/sum(I(:).^2); 
NP=abs(fftn(noise)).^2; 
NPOW=sum(NP(:))/numel(noise); 
NCORR=fftshift(real(ifftn(NP)));
IP=abs(fftn(I)).^2; 
IPOW=sum(IP(:))/numel(I); 
ICORR=fftshift(real(ifftn(IP)));
subplot(1,3,1);imshow(BlurredNoisy,[min(min(BlurredNoisy)) max(max(BlurredNoisy))]);
subplot(1,3,2);imshow(deconvwnr(BlurredNoisy,PSF,NSR),[]);
subplot(1,3,3);imshow(deconvwnr(BlurredNoisy,PSF,NCORR,ICORR),[]);
%6.4
I = imread('trui.png');  
PSF=fspecial('gaussian',7,10); 
V=.01;
BlurredNoisy=imnoise(imfilter(I,PSF),'gaussian',0,V);
NP=V.*numel(I); 
[J,LAGRANGIAN_J]=deconvreg(BlurredNoisy,PSF,NP);
[K,LAGRANGIAN_K]=deconvreg(BlurredNoisy,PSF,[],LAGRANGIAN_J*10);
subplot(1,3,1);imshow(BlurredNoisy);
subplot(1,3,2);imshow(J); 
subplot(1,3,3);imshow(K);
%6.5
A=imread('test_blur.jpg');
A=edgetaper(A,ones(25)); 
[J,~]=deconvblind(A,ones(10));
subplot(1,4,1), imshow(A,[]); 
subplot(1,4,2), imshow(J,[]); 

h=fspecial('gaussian',[10 10],3);
[J,PSF]=deconvblind(A,h);
subplot(1,4,3), imshow(J,[]);
J=deconvwnr(A,PSF,0.01);
subplot(1,4,4), imshow(J,[]);
%6.6
A=imread('trui.png'); A=mat2gray(double(A)); 
PSF=fspecial('gaussian',7,10); 
V=.0001; 
J0=imnoise(imfilter(A,PSF),'gaussian',0,V); 
WT = zeros(size(A));WT(5:end-4,5:end-4) = 1;	
J1=deconvlucy(J0,PSF,10); 
J2=deconvlucy(J0,PSF,20,sqrt(V)); 
J3=deconvlucy(J0,PSF,20,sqrt(V),WT);
subplot(141);imshow(J0);
subplot(142);imshow(J1);
subplot(143);imshow(J2);
subplot(144);imshow(J3);
