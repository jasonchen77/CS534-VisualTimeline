clear;clc;

img1 = imread('highline-before.0.jpg');
img2 = imread('highline-after.0.jpg');

%img1 = histEqualize(img1);
%img2 = histEqualize(img2);

img1D = im2double(img1);
img2D = im2double(img2);
% imgt1 = colorTransfer(img1,img2);
% imgt2 = colorTransfer(img2,img1);
% img1D = im2double(imgt1);
% img2D = im2double(imgt2);

output_laplacian = pyramidBlend(img1D,img2D);

imshow(output_laplacian);
imwrite(output_laplacian, 'highline-blended.jpg');