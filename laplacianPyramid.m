function [ im_laplacian ] = laplacianPyramid( im_original, im_gaussian )
%Given an original image and the gaussian of that original image, 
%calculates the laplacian pyramid
%   Pre-conditions: 
%       'im_original' and 'im_guassian' are both RGB images where 
%       im_gaussian is 2X smaller than im_original
%   Post-conditions:
%       'im_laplacian' is the difference of the original and gaussian image

%LAPLACIAN PYRAMID CONSTRUCTION:
%1. Given a Gaussian Pyramid, expand it to 2x the size
%2. Save the difference between the two layers of Gaussian Pyramids

%probably a better way to check sizes!
im_laplacian = impyramid(im_gaussian, 'expand');

%ensure images are the same size
[im_original, im_laplacian] = resize(im_original, im_laplacian);

im_laplacian = im_original - im_laplacian;

end

