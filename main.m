clear;clc;

%read in original images
img1 = imread('highline-before.0.jpg');
img2 = imread('highline-after.0.jpg');

%option to equalize images before creating visual timeline
%img1 = histEqualize(img1);
%img2 = histEqualize(img2);

%convert images to double
img1D = im2double(img1);
img2D = im2double(img2);
%option to transfer color between images before creating visual timeline
% imgt1 = colorTransfer(img1,img2);
% imgt2 = colorTransfer(img2,img1);
% img1D = im2double(imgt1);
% img2D = im2double(imgt2);

%create visual timeline via pyramid blend
output_laplacian = pyramidBlend(img1D,img2D);

%show the output image and save
imshow(output_laplacian);
imwrite(output_laplacian, 'highline-blended.jpg');