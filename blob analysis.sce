//This code is for blob analysis of the image to find the location of the red patches present in the image



global IPD_PATH;
RGB= ReadImage(IPD_PATH + 'demos\image.png'); //image corresponds to the original image here

Image= RGB2Gray(RGB);
InvertedImage=uint8(255*ones(size(Image,1),size(Image,2)))-Image;

Threshold=75; //using the histogram of the image
LogicalImage= SegmentByThreshold(InvertedImage,Threshold);
ObjectImage= SearchBlobs(LogicalImage);
figure();ShowImage(LogicalImage,'LogicalImage');// conversion to logical image
NumberOfObjects=double(max(ObjectImage));
figure(); ShowImage(ObjectImage,'result OF BLOB', jetcolormap(NumberOfObjects));




// edging of green part of the image
global IPD_PATH;
global EDGE_SOBEL;
RGB= ReadImage(IPD_PATH + 'demos\image.png');

Image= RGB2Gray(RGB);
GradientImage= EdgeFilter(Image,EDGE_SOBEL);
MarkerImage=int32(zeros(size(Image,1),size(Image,2)));// for outlining the image, for which if pixel location is known using imagetool option,edges can be made.
MarkerImage(172,46)= 1; MarkerImage(154,117)= 2; //(x,y) location of a 2D image
MarkerImage(140,286)=3; MarkerImage(199,336);
MarkerImage(216,141)=5; MarkerImage(241,463)=6;
MarkerImage(260,368)=7;
SegmentedImage= uint8(Watershed(GradientImage,MarkerImage));
figure();ShowImage(SegmentedImage,'segmented Image'); //watershed transform




global IPD_PATH;

RGB= ReadImage(IPD_PATH + 'demos\teaset.png');

Image= RGB2Gray(RGB);
global EDGE_SOBEL;

GradientImage= EdgeFilter(Image,EDGE_SOBEL);

EdgeImage=~SegmentByThreshold(GradientImage,60);
DistanceImage= DistanceTransform(EdgeImage);
ThresholdImage= SegmentByThreshold(DistanceImage,8);
MarkerImage= SearchBlobs(ThresholdImage);
SegmentedImage= Watershed(GradientImage,MarkerImage);//segmentation using distance length




//connected areas according to the new threshold (only red patches are visible)
global IPD_PATH;
RGB= ReadImage(IPD_PATH + 'demos\image.png');

Image= RGB2Gray(RGB);
InvertedImage= uint8(255*ones(size(Image,1),size(Image,2)))-Image;
Threshold= 80;

LogicalImage= SegmentByThreshold(InvertedImage,Threshold);
ObjectImage= SearchBlobs(LogicalImage);

[CumulatedSizeHistogram ListOfSizes]= CumulateSizeHistogram(ObjectImage);
figure(); plot(ListOfSizes,CumulatedSizeHistogram);
SizeThreshold=28000;
FilteredObjectImage= FilterBySize(ObjectImage,SizeThreshold);

figure();ShowImage(FilteredObjectImage,'four biggest connected areas',jetcolormap(4));//cumulated size histogram







//for further research (**code not implemented**) i.e. it can be modified for approximation of patches with any morphological form.
IsCalculated= CreateFeatureStruct(); IsCalculated.BoundingBox = %t;
BlobStatistics = AnalyzeBlobs(FilteredObjectImage, IsCalculated);
FigureWindow= ShowColorImage(RGB, 'Image with Boundry Boxes around the objects');
DrawBoundingBoxes(BlobStatistics,[0 0.5 0],FigureWindow);






Image= SegmentByThreshold(InvertedImage,Threshold);
Image(:, 3) = 0 // draw dark line

Image(:, 7) = 1 // draw light line

StructureElement = CreateStructureElement('square', 3) // generate structuring element

global FILTER_DILATE;

ResultImage = MorphologicalFilter(Image, FILTER_DILATE, StructureElement.Data)
 
figure();ShowImage(ResultImage,'result Image');








