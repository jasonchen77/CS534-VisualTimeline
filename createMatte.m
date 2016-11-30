function [ R ] = createMatte( im_1, im_2)
%Returns Gaussian blended matte that is the same size as the input images
%   Detailed explanation goes here

[im_1, im_2] = resize(im_1, im_2);
im_1 = uint8(im_1);
im_2 = uint8(im_2);
R = ones(size(im_1));
m2 = size(im_1,2);
R = cat(2,0*R(:,1:(m2/2),:),R(:,(m2/2)+1:m2,:));
R = impyramid(impyramid(R, 'reduce'), 'expand');
[R, im_2] = resize(R, im_2);


end

