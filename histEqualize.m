function [ outimg ] = histEqualize( img )
% A function that performs histogram equalization on a given input image

outimg = im2double(img);

% convert an input color image from RGB to
% HSV color space (using rgb2hsv which creates a double image) 
outimg = rgb2hsv(outimg);

% Compute the histogram and cumulative histogram of the V (luminance) 
% image only
V = outimg(:,:,3);
c = cumsum(imhist(outimg(:,:,3)));

V = uint8(V*255);

% Transform the intensity values in V to occupy the full range 
% 0..255 in a new image W so that the histogram
% of W is roughly “flat"
[x, y, ~] = size( img );
totalPixels = x*y;

for i = 1:x
    for j = 1:y
        W(i,j) = max(0, ((256/totalPixels)*c(V(i,j)+1))-1);
    end
end

% Combine the original H and S channels with the W image to
% create a new color image, which is then converted to an RGB color 
% output image (using hsv2rgb)
W = W/255;
outimg(:,:,3) = W; 
outimg = hsv2rgb(outimg);

end

