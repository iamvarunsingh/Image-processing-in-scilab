//The starting steps of image processing for the given image is presented in this scinotes.
//the images are named accordingly and to download the images directly,you can log on to "https://drive.google.com/folderview?id=0B-hExKho8d7eUTFpaTZiYUFtU2M&usp=sharing"
//This code is an open source file with no copyright and was developed during an internship program in IIT Bombay by FOSSEE team (Varun Singh).
//These codes requires toolboxes such as IPD 8.0 and SIVP 0.5.3.1 executed, to work. 



global IPD_PATH;
RGB= ReadImage(IPD_PATH + 'demos\image.png'); //"image.png" here represents the original image

Image= RGB2Gray(RGB);
figure(); ShowColorImage(RGB,'Color Image'); //Shows original image (stacksize max)

figure(); ShowImage (Image, 'Gray Level Image');// shows gray level
figure(); ShowImage (Image, 'Pseudo Color Image', jetcolormap(256));// pseudo color

Histogram= CreateHistogram(Image);// creates the histogram of image
figure();plot(0: 255, Histogram);

figure(); ImageTool(Image);// for manual pixel location

figure(); A=ShowImage(RGB(:,:,1), 'Red Channel');
// **important** conversion to red channel 

figure(); B=ShowImage(RGB(:,:,2), 'Green Channel');
 // **important** conversion to green channel 


imwrite(A,'red patches.png'); // writing the observed red channel image **execute SIVP**
imwrite(B,'green patches.png');// writing the observed red channel image **execute SIVP**









RGB= ReadImage('C:\Users\varun singh\Desktop\Matlab\red patches.png');
//calling of writen red patches.

Image= RGB2Gray(RGB);
InvertedImage= uint8(255*ones(size(Image,1),size(Image,2)))-Image;
Histogram= CreateHistogram(InvertedImage);// histogram of red (patches) image.
figure();plot(0:255,Histogram);

LogicalImage= SegmentByThreshold(InvertedImage,99); //logical image conversion
figure(); ShowImage(Image,'Original Image');// shows original red image
figure(); ShowImage(InvertedImage,'Invereted Image');//shows inverted image
figure(); ShowImage(LogicalImage,'Logical Image');//shows logical image
ImageTool(Image);// makes it easy for the user to check pixel locations manually.

//EDGE DETECTION(IMPORTANT)
imwrite(LogicalImage,'logical.png');

im = imread('C:\Users\varun singh\Desktop\Matlab\red patches.png');// calling red image in SIVP imread function
im = rgb2gray(im);
E = edge(im, 'sobel');
imshow(E); //for edge sobel

E = edge(im, 'canny', [0.06, 0.2]);
imshow(E); //for canny sobel **important**

E = edge(im, 'sobel', -1);
imshow(mat2gray(E)); //mat2gray conversion of sobel.

I = imread('C:\Users\varun singh\Desktop\Matlab\ed.png');// ed.png is the canny edge image.

[ii] = find(I>0);// find and size function to find the pixel count.

pixelcount = size(ii) //find and size function to find the pixel count

close()
im= imread('C:\Users\varun singh\Desktop\Matlab\images\image.png');
imshow(im);

a=rgb2gray(im);


imshow(a);
b=im2bw(a,0.1);// conversion in binary
imwrite(b,'b.png');
imshow(b) // binary green patches only because of 0.1 threshold
[r,c]=size(b) // checking the size of rows and columns of the whole image







//Logical image using Otsu method. (secondary program for logical image)

Threshold= CalculateOtsuThreshold(InvertedImage);
Threshold= 52;
LogicalImage= SegmentByThreshold(InvertedImage,Threshold);
figure();ShowImage(LogicalImage,'Result of threshold');
ImageTool(Image);



Image//an hypermatrix
[i,j]=find(Image>200)// to find the red patches location in the matrix using threshold  (note that images written in scilab,may it be logical, are converted into matrices with 0 to 255 values) 






//cropping of the patches to find the centroid
CroppedInvertedImage= InvertedImage(0 : 364,0 : 287);
Threshold= CalculateOtsuThreshold(InvertedImage);
Threshold= 90;
LogicalImage= SegmentByThreshold(CroppedInvertedImage,Threshold);
figure();ShowImage(LogicalImage,'segmented cropped image');




//Calling the red patches image and finding the centroid location of the image from where the distance is to be measured.**important**

S= imread('C:\Users\varun singh\Desktop\Matlab\red patches.png');
ShowColorImage(S,'0');

S2= rgb2gray(S);
ShowImage(S2,'0');
S3=S2>160;
ShowImage(S3,'0');

se = CreateStructureElement('vertical_line', 10);
S4 = ErodeImage(S3, se);
se = CreateStructureElement('horizontal_line', 10);
S4 = ErodeImage(S4, se);
ShowImage(S4,'0');


S5 = S4.*1;
IsCalculated = CreateFeatureStruct(%f); // Feature struct is generated.
IsCalculated.Centroid = %t; // The bounding box shall be calculated for each blob.
S6 = AnalyzeBlobs(S5, IsCalculated);
ShowColorImage(S,'0');
plot(S6(1).Centroid(1),S6(1).Centroid(2),'r*');







//Secondary approach and centroid detection of sample patch
//The distance can be calculated using L*a*b function of IPD tool and it is executed here below.

RGBAsDouble = double (RGB)/ 255;
LAB = RGB2LAB(RGBAsDouble);

ListOfChannels = ['L*', 'a*', 'b*'];
for n=1: size(ListOfChannels, 2)    
    Minimum=min(LAB(:,:,n));Maximum=max(LAB(:,:,n));   
     
    NormalizedChannel= (LAB(:,:,n)- Minimum)/(Maximum-Minimum);  
    [Histogram,ListOfBins]= CreateHistogram(NormalizedChannel,100);   
     
    figure(); ShowImage(NormalizedChannel,ListOfChannels(n));
    figure();plot(ListOfBins,Histogram);
       
    end
    
    
    
    
    
    
    
    
  


