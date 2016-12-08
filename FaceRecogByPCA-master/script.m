clc,clear;


prompt = {'Enter test image name (a number between 1 to 10):'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {' '};
x = inputdlg(prompt,dlg_title,num_lines,def);
mypi=raspi

if isequal(x{1},'1')
    
cam=cameraboard(mypi,'Resolution','640x480','Quality',100)
cam.Rotation = 180
for ii = 1:155
    img = snapshot(cam);
  
    imagesc(img), title('YUP'), drawnow;

end
i = img;
gray = rgb2gray(i);

figure(2)
imshow(gray)

c1 = imresize(gray,[500,500])

imshow(c1)
imwrite(c1,'Testing_10.jpg');
imageinfo;
imsave;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


trainingDataPathList1 = getNodes(uigetdir('.','trainingDataPathList1'));

 imgcount = size(trainingDataPathList1 , 1);
    for i=1 : imgcount

	    I = imread(trainingDataPathList1(i,: ));
        gray = double(I(:,:,1));

        [u, s, v] = svds(gray);
        imgray = uint8( u * s * transpose(v));

        figure,

        subplot(1,1,1), subimage(imgray,title('OUTPUT IMAGE'))
        imageinfo;
        imsave
    
    end
    
   [filename1, pathname1]  = uigetfile('.','testImgPath');
   testImgPath2 = [pathname1 filename1];

   
        A = imread(testImgPath2);
        gray = double(A(:,:,1));

        [u, s, v] = svds(gray);
        imgray = uint8( u * s * transpose(v));

        figure,

        subplot(1,1,1), subimage(imgray,title('OUTPUT IMAGE'))
        imageinfo;
        imsave

close all



trainingDataPathList = getNodes(uigetdir('.','trainingDataPathList'));
[filename, pathname]  = uigetfile('.','testImgPath');
testImgPath = [pathname filename];

bit = facerecog(trainingDataPathList,testImgPath);
     for i = 1:10
         if(bit == 1)
            writeDigitalPin(mypi,23,1);
            pause(0.5);
            writeDigitalPin(mypi,23,0);
            pause(0.5);
            
         else if(bit == 0)
                writeDigitalPin(mypi,24,1);
                pause(0.5);
                writeDigitalPin(mypi,24,0);
                pause(0.5);
             end
         end
         
     end