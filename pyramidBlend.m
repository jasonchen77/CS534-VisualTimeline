function [ im_blended ] = pyramidBlend( im_in1, im_in2 )
%Given two input image,create a third using Laplacian pyramid blending
%   Pre-conditions: 
%       'im_in1' and 'im_in2' are both RGD images of the same size
%   Post-conditions:
%       'im_blended' is the blended RGB image of im_in1 and im_in2

assert(all(size(im_in1) == size(im_in2)));
    assert(size(im_in1, 3) == 3);

%LAPLACIAN PYRAMID BLENDING:
%1. Build laplacian pyramids L1 and L2 corresponding to images 1 and 2
%   just doing 1 layer for the first pass of this algo!
im1_g1 = impyramid(im_in1, 'reduce');
im2_g1 = impyramid(im_in2, 'reduce');

im1_g2 = impyramid(im1_g1, 'reduce');
im2_g2 = impyramid(im2_g1, 'reduce');

im1_l1 = laplacianPyramid(im1_g1, im1_g2);
im2_l1 = laplacianPyramid(im2_g1, im2_g2);

%2. Build Gaussian pyramid GR from selected region R
%   The output matte R must be the same size as the final image and input
%   images. Right now, it is split down the center, though later it would
%   be better to find this automatically using seam finding!

R = 255*ones(size(im_in1)); %assuming im1_l1 ad im2_l2 still same size
m2 = size(im_in1,2);
R = cat(2,0*R(:,1:int16(m2/2),:),R(:,int16(m2/2)+1:m2,:));
R_g = impyramid(impyramid(impyramid(R, 'reduce'), 'reduce'), 'expand');

%3. Form a combined pyramid LS from L1 and L2 using nodes of GR
%   as weights:
R_g = uint8(R_g);
result_l = R_g.*im1_l1+(255-R_g).*im2_l1;

%4. Collapse the LS pyramid to get the final blended image



end

