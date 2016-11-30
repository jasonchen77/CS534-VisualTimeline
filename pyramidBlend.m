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
im1_l1 = laplacianPyramid(im1_g1, im1_g2);
im2_l1 = laplacianPyramid(im2_g1, im2_g2);

im1_l2 = laplacianPyramid(im1_g2, im1_g3);
im2_l2 = laplacianPyramid(im2_g2, im2_g3);

%2. Build Gaussian pyramid GR from selected region R
%   The output matte R must be the same size as the final image and input
%   images. Right now, it is split down the center, though later it would
%   be better to find this automatically using seam finding!

% R = 255*ones(size(im_in1)); %assuming im1_l1 ad im2_l2 still same size
% m2 = size(im_in1,2);
% R = cat(2,0*R(:,1:int16(m2/2),:),R(:,int16(m2/2)+1:m2,:));
% R_g = impyramid(impyramid(impyramid(R, 'reduce'), 'reduce'), 'expand');

R = ones(size(im_in1)); %assuming im1_l1 ad im2_l2 still same size
m2 = size(im_in1,2);
R = cat(2,0*R(:,1:(m2/2),:),R(:,(m2/2)+1:m2,:));
R_g = impyramid(impyramid(impyramid(R, 'reduce'), 'reduce'), 'expand');

%R_g1 = impyramid(impyramid(impyramid(impyramid(R, 'reduce'), 'reduce'), 'reduce'), 'expand');
R_g1 = impyramid(impyramid(impyramid(R_g, 'reduce'), 'reduce'), 'expand');
%3. Form a combined pyramid LS from L1 and L2 using nodes of GR
%   as weights:
% R_g = (R_g);
% result_l = R_g.*im1_l1+(255-R_g).*im2_l1;

result_l = R_g.*im1_l1+(1-R_g).*im2_l1;

% Normalizing values   
    l_R = result_l(:,:,1);
    l_G = result_l(:,:,2);
    l_B = result_l(:,:,3);

    minM = min(min(l_R));
    maxM = max(max(l_R));
    normBWD = (l_R - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_R = epNormBWD;

    minM = min(min(l_G));
    maxM = max(max(l_G));
    normBWD = (l_G - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_G = epNormBWD;
    
    minM = min(min(l_B));
    maxM = max(max(l_B));
    normBWD = (l_B - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_B = epNormBWD;
    
    result_l = cat(3, l_R, l_G, l_B);
    
    %***************3rd Layer, probably need a loop for this section
    
    result_l1 = R_g1.*im1_l2+(1-R_g1).*im2_l2;
    l_R = result_l1(:,:,1);
    l_G = result_l1(:,:,2);
    l_B = result_l1(:,:,3);

    minM = min(min(l_R));
    maxM = max(max(l_R));
    normBWD = (l_R - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_R = epNormBWD;

    minM = min(min(l_G));
    maxM = max(max(l_G));
    normBWD = (l_G - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_G = epNormBWD;
    
    minM = min(min(l_B));
    maxM = max(max(l_B));
    normBWD = (l_B - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_B = epNormBWD;
    
    result_l1 = cat(3, l_R, l_G, l_B);
    
    %**************
    
    R_g2 = impyramid(impyramid(impyramid(R_g1, 'reduce'), 'reduce'), 'expand');
    R_g3 = impyramid(impyramid(impyramid(R_g2, 'reduce'), 'reduce'), 'expand');
    R_g4 = impyramid(impyramid(impyramid(R_g3, 'reduce'), 'reduce'), 'expand');
    result_g3 = R_g2.*im1_g3+(1-R_g2).*im2_g3;
%     result_g2 = R_g3.*im1_g2+(1-R_g3).*im2_g2;
%     result_g1 = R_g4.*im1_g1+(1-R_g4).*im2_g1;
    
%4. Collapse the LS pyramid to get the final blended image

im_blended = impyramid(result_l2, 'expand');
im_blended = impyramid(result_l1, 'expand')+ result_l(1:257,:,:);
im_blended = result_l;



end

