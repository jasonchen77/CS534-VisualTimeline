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

%
im1_g3 = impyramid(im1_g2, 'reduce');
im2_g3 = impyramid(im2_g2, 'reduce');

%
im1_l0 = laplacianPyramid(im_in1, im1_g1);
im2_l0 = laplacianPyramid(im_in2, im2_g1);

im1_l1 = laplacianPyramid(im1_g1, im1_g2);
im2_l1 = laplacianPyramid(im2_g1, im2_g2);
[im1_l1, im1_g1] = resize(im1_l1, im1_g1);
[im2_l1, im2_g1] = resize(im2_l1, im2_g1);

im1_l2 = laplacianPyramid(im1_g2, im1_g3);
im2_l2 = laplacianPyramid(im2_g2, im2_g3);
[im1_l2, im1_g2] = resize(im1_l2, im1_g2);
[im2_l2, im2_g2] = resize(im2_l2, im2_g2);

%2. Build Gaussian pyramid GR from selected region R
%   The output matte R must be the same size as the final image and input
%   images. Right now, it is split down the center, though later it would
%   be better to find this automatically using seam finding!

% STANDARD MATTE CREATION:
% R = ones(size(im_in1)); %assuming im1_l1 ad im2_l2 still same size
% m2 = size(im_in1,2);
% R = cat(2,0*R(:,1:(m2/2),:),R(:,(m2/2)+1:m2,:));

% SEAM FINDING MATTE CREATION:
%find seam
S = findSeam(im_in1);
%create output matte of correct size
[m,n,~] = size(im_in1);
R = ones(n,m,3);
for c = 1:m
    border = S(c);
    R(:,c,:) = cat(1,0*R(1:(border-1),c,:),1*R(border:n,c,:));
end

%rotate matte to correct orientation
R = permute(R, [2 1 3]);

[R, im1_l0] = resize(R, im1_l0);
R_g1 = impyramid(impyramid(impyramid(R, 'reduce'), 'reduce'), 'expand');
% R_g = createMatte(im1_l1, im2_l1);

R_g2 = impyramid(impyramid(impyramid(R_g1, 'reduce'), 'reduce'), 'expand');

%3. Form a combined pyramid LS from L1 and L2 using nodes of GR
%   as weights:
result_l0 = normalize(R.*im1_l0+(1-R).*im2_l0);
result_l1 = normalize(R_g1.*im1_l1+(1-R_g1).*im2_l1);
result_l2 = normalize(R_g2.*im1_l2+(1-R_g2).*im2_l2);
    
R_g2 = impyramid(impyramid(impyramid(R_g1, 'reduce'), 'reduce'), 'expand');
R_g3 = impyramid(impyramid(impyramid(R_g2, 'reduce'), 'reduce'), 'expand');
result_g3 = R_g3.*im1_g3+(1-R_g3).*im2_g3;
result_g2 = R_g2.*im1_g2+(1-R_g2).*im2_g2;
result_g1 = R_g1.*im1_g1+(1-R_g1).*im2_g1;
    
%4. Collapse the LS pyramid to get the final blended image

%im_blended = impyramid(result_l2, 'expand');
%im_blended = impyramid(result_l1, 'expand')+ result_l(1:257,:,:);

%----Testing codes, modify or delete later-----------------
%expand first level pyramid
g1X = impyramid(result_g1, 'expand');
[l0X, g1X] = resize(result_l0, g1X);

im_blended = l0X + g1X;

%expand second level pyramid and add to first
g2X = impyramid(result_g2, 'expand');
[l1X, g2X] = resize(result_l1, g2X);

im_blended_2 = impyramid(l1X + g2X, 'expand');
[im_blended, im_blended_2] = resize(im_blended, im_blended_2);

im_blended = im_blended + im_blended_2;

%must divide to ensure all colors are visible
im_blended = im_blended/4;

% im_blended = seamFindingTest(im_blended);
%-----------------------------------------------------------


end

