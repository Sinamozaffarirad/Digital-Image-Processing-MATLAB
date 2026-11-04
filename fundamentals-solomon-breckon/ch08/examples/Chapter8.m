%Example 8.1
bw = imread('cameraman.tif');              
se=[0 1 0; 1 1 1; 0 1 0];                   
bw_out=imdilate(bw,se);                  
subplot(1,2,1), imshow(bw);             
subplot(1,2,2), imshow(bw_out); 

%Example 8.2
bw = imread('text.png');                
se=ones(6,1);                           
bw_out=imerode(bw,se);                  
subplot(1,2,1), imshow(bw);             
subplot(1,2,2), imshow(bw_out); 

%Example 8.3
bw = imread('text.png');                
se1 = strel('square',4)                    
se2 = strel('line',5,45)             
bw_1=imdilate(bw,se1);                  
bw_2=imerode(bw,se2);                    
subplot(1,2,1), imshow(bw_1);             
subplot(1,2,2), imshow(bw_2);        

%Example 8.4
length=18; tlevel=0.2;                                         
A=imread('circuit.tif'); subplot(2,3,1); subplot(2,3,2) , imhist(A);           
B=im2bw(A,tlevel); subplot(2,3,2), imshow(~B);              
SE=ones(3,length); bw1=imerode(~B,SE);               
subplot(2,3,3), imshow(bw1);                                    
bw2=imerode(bw1,SE'); subplot(2,3,4), imshow(bw2);              
bw3=imdilate(bw2,SE');bw4=imdilate(bw3,SE);                     
subplot(2,3,5), imshow(bw4);                                    
boundary=bwperim(bw4);[i,j]=find(boundary);                  
subplot(2,3,6), imshow(A); hold on; plot(j,i,'r.');

%Example 8.5
A=imread('cameraman.tif'); subplot(1,3,1), imshow(A);                 
bw=~im2bw(A,0.5); bw = imfill(bw,'holes');                          
subplot(1,3,2), imshow(bw);                                     

[L,num_0]=bwlabel(bw);                                          
                                                                
se=strel('disk',2);                                              
count =0;                                                             
num=num_0;                                                       

while num>0                                                      
count=count+1
    bw=imerode(bw,se);                                         
    [L,num]=bwlabel(bw);                                        
    P(count)=num_0-num;                                             
    figure(2); imshow(bw); drawnow;                                
end

    figure(2); subplot(1,2,1), plot(0:count,[0 P],'ro');           
    axis square;axis([0 count 0 max(P)]);                           
    xlabel('Size'); ylabel('Particles removed')                    
    subplot(1,2,2), plot(diff([0 P]),'k*'); axis square;  
    
%Example 8.6
A=imread("openclose_shapes.png"); A=~logical(A);            
se=strel('disk',3); bw1=imopen(A,se); bw2=imclose(A,se);  
subplot(3,2,1), imshow(bw1); subplot(3,2,2), imshow(bw2);
se=strel('disk',6); bw1=imopen(A,se); bw2=imclose(A,se);  
subplot(3,2,3), imshow(bw1); subplot(3,2,4), imshow(bw2);  
se=strel('disk',15); bw1=imopen(A,se); bw2=imclose(A,se);  
subplot(3,2,5), imshow(bw1); subplot(3,2,6), imshow(bw2);

%Example 8.7
A=imread('circles.png');                    
bw=bwperim(A);                              
se=strel('disk',5); bw1=A-imerode(A,se);    
subplot(1,3,1), imshow(A);
subplot(1,3,2), imshow(bw);
subplot(1,3,3), imshow(bw1);             

%Example 8.8
bw=imread("basic_shapes.png");                         
[L,num]=bwlabel(bw);                                   
subplot(1,2,1), imagesc(bw); axis image; axis off;     
colorbar('North'); subplot(1,2,2), imagesc(L);        
axis image; axis off; colormap(jet); colorbar('North')

%Example 8.9
A = imread('text.png');                                
B=imcrop(A);                                      
se1=B; se2=~B;                                    
bw=bwhitmiss(A,se1,se2);                        
[i,j]=find(bw==1);                                
subplot(1,3,1), imshow(A);                        
subplot(1,3,2), imagesc(B); axis image; axis off; 
subplot(1,3,3), imshow(A); hold on; plot(j,i,'r*');

%Example 8.10
A=imread("Noisy_Two_Ls.png");                      
                                          
se1=[0 0 0; 1 1 0; 0 1 0];                
se2=[1 1 1; 0 0 1; 0 0 1];                         
bw=bwhitmiss(A,se1,se2);                    
subplot(2,2,1), imshow(A,[0 1]);            
subplot(2,2,2), imshow(bw,[0 1]);                  

                                            
interval=[-1 -1 -1; 1 1 -1; 0 1 -1];        
                                                  
bw=bwhitmiss(A,interval);                 
subplot(2,2,3), imshow(bw,[0 1]);                   

                                            
interval=[0 -1 -1; 0 1 -1; 0 0 0];          
bw=bwhitmiss(A,interval);                    
subplot(2,2,4), imshow(bw,[0 1]);                

%Example 8.11
A=imread("open_shapes.png");                                    
se=strel('disk',10); bw=imopen(A,se);                              
subplot(1,3,1), imshow(A); title('Original Image');                 
subplot(1,3,2), imshow(bw); title('Opening - disk radius=10');    
se=strel('square',25); bw=imopen(A,se);                       
subplot(1,3,3), imshow(bw); title('Opening - square side=25');   

%Example 8.12
mask=~imread("open_shapes.png");                                                    
mask=imclose(mask,ones(5));             
se=strel('line',40,90);                    
marker=imerode(mask,se);                  
im=imreconstruct(marker,mask);            
subplot(3,1,1), imshow(~mask); title('Original mask Image');
subplot(3,1,2), imshow(~marker); title('marker image');
subplot(3,1,3), imshow(~im); title('Opening by reconstruction');

%Example 8.14
A=imread('cameraman.tif');                            
se=strel(ones(3));                            
Amax=imdilate(A,se);                             
Amin=imerode(A,se);                           
Mgrad=Amax-Amin;                                    
subplot(1,3,1), imagesc(Amax); axis image; axis off;   
subplot(1,3,2), imagesc(Amin); axis image; axis off;
subplot(1,3,3), imagesc(Mgrad); axis image; axis off;
colormap(gray);

%Example 8.15
I = imread("rice.png");                            
background = imopen(I,strel('disk',15));    
I2 = imsubtract(I,background);                      
I3 = imadjust(I2);                                
subplot(2, 4, 1), imshow(I), title('Original Image');
subplot(2, 4, 2), imshow(background), title('Background');
subplot(2, 4, 3), imshow(I2), title('Subtracted Image');
subplot(2, 4, 4), imshow(I3), title('Adjusted Image');
subplot(2, 4, 5), imhist(I);
subplot(2, 4, 6), imhist(background);
subplot(2, 4, 7), imhist(I2);
subplot(2, 4, 8), imhist(I3);