function [ im_blended ] = pyramidBlend( im_in1, im_in2 )
%Given two input image,create a third using Laplacian pyramid blending
%   Pre-conditions: 
%       'im_in1' and 'im_in2' are both RGD images of the same size
%   Post-conditions:
%       'im_blended' is the blended RGB image of im_in1 and im_in2

%GAUSSIAN PYRAMID REDUCTION:
%USE: impyramid(im_in1, 'reduce') to accomplish the following:
%1. Gaussian pre-filter image
%2. Subsample by throwing away every other row and column to create
%   image scaled down by 2
%3. Repeat steps 1 and 2 until desired number of levels reached
%   Gaussian filter size should double for each 1/2 size reduction

%LAPLACIAN PYRAMID CONSTRUCTION:
%1. Given a Gaussian Pyramid, expand it to 2x the size
%2. Save the difference between the two layers of Gaussian Pyramids

%LAPLACIAN PYRAMID BLENDING:
%1. Build laplacian pyramids L1 and L2 corresponding to images 1 and 2
%2. Build Gaussian pyramid GR from selected region R
%3. Form a combined pyramid LS from L1 and L2 using nodes of GR
%   as weights:
%   LS(i,j) = GR(1,j)*L1(1,j)+(1-GR(1,j)*L2(1,j)
%4. Collapse the LS pyramid to get the final blended image

end

