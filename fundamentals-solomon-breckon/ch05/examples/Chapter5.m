%5.1.1
A=imread('BBC_grey_testcard.png'); 		
FA=fft2(A); FA=fftshift(FA);		
PSF=fspecial('gaussian',size(A),6);			
OTF=fft2(PSF); OTF=fftshift(OTF);		
Afilt=ifft2(OTF.*FA); Afilt=fftshift(Afilt);		
subplot(1,4,1);imshow(A,[]);  colormap(gray);	
subplot(1,4,2); imagesc(log(1+(PSF))); axis image; axis off; 
subplot(1,4,3); imagesc(log(1+abs(OTF))); axis image; axis off;
subplot(1,4,4); imagesc(abs(Afilt)); axis image; axis off;
 %5.1.2
PSF=fspecial('gaussian',size(A),6);			
OTF=fft2(PSF); OTF=fftshift(OTF);		
rlow=(size(A,1)./2)-3; rhigh=(size(A,1)./2)+3;	
clow=(size(A,2)./2)-3; chigh=(size(A,2)./2)+3;
Fphase=angle(OTF); 				
Fphase(rlow:rhigh,clow:chigh)=Fphase(rlow:rhigh,clow:chigh) + pi.*rand(size(Fphase(rlow:rhigh,clow:chigh)));
					
OTF=abs(OTF).*exp(i.*Fphase);			
Afilt=ifft2(OTF.*FA); Afilt=fftshift(Afilt);		
psfnew=abs(fftshift((otf2psf(OTF)))); 		
subplot(1,4,2); imagesc(log(1+psfnew)); axis image; axis off; colormap(gray);
subplot(1,4,3); imagesc(log(1+abs(OTF))); axis image; axis off;
subplot(1,4,4); imagesc(abs(Afilt)); axis image; axis off;
%5.1.3
PSF=fspecial('motion',30,30);
OTF=psf2otf(PSF,size(A));
    OTF=fftshift(OTF);
Afilt=ifft2(OTF.*FA);
subplot(1,4,1);imshow(A,[]); 
subplot(1,4,2); imshow(log(1 + PSF),[]);
subplot(1,4,3); imshow(log(1 + abs (OTF)),[])
subplot(1,4,4); imshow(abs(Afilt),[]);
%5.2
A=imread('cameraman.tif');                         
FT=fft2(A); FT_centred=fftshift(FT);                   
subplot(2,3,1), imshow(A);                          	
subplot(2,3,2), imshow(log(1+abs(FT)),[]);          	
subplot(2,3,3), imshow(log(1+abs(FT_centred)),[]);      
 
Im1=abs(ifft2(FT)); subplot(2,3,5), imshow(Im1,[]); 	
Im2=abs(ifft2(FT_centred)); subplot(2,3,6), imshow(Im2,[]);

figure;
[xd,yd]=size(A); x=-xd./2:xd./2-1; y=-yd./2:yd./2-1;
[X,Y]=meshgrid(x,y); sigma=32; 
arg=(X.^2+Y.^2)./sigma.^2; frqfilt=exp(-arg);    
imfilt1=abs(ifft2(frqfilt.*FT));                    
imfilt2=abs(ifft2(frqfilt.*FT_centred));            	
subplot(1,3,1), imshow(frqfilt,[]);                 	
subplot(1,3,2), imshow(imfilt1,[]); 
subplot(1,3,3), imshow(imfilt2,[]); 
