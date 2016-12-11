clear;

img1 = imread('doyers-before.0.jpg');
img2 = imread('doyers-after.0.jpg');

%img1 = histEqualize(img1);
%img2 = histEqualize(img2);

img1D = im2double(img1);
img2D = im2double(img2);
%imgt1 = colorTransfer(img1,img2);
%imgt2 = colorTransfer(img2,img1);
%img1D = im2double(imgt1);
%img2D = im2double(imgt2);

%[cImg1, cImg2] = combine(img1D, img2D);
cImg = combine(img1D, img2D);
%output_image = zeros(size(img1,1), size(img1, 2), 3);
output_laplacian = pyramidBlend(img1D,img2D);
output_image = fBlend(img1D, img2D);

%output_image = fBlend(cImg, cImg);

imshow(output_laplacian);
imwrite(output_laplacian, 'doyle-blended.jpg');