function [ outimg ] = histEqualize( img )
%a function that performs histogram equalization
outimg = im2double(img);

% (1) converting an input color image from RGB to
% HSV color space (using rgb2hsv which creates a double image) 
outimg = rgb2hsv(outimg);

%(2) computing the histogram and cumulative histogram of the V (luminance) 
% image only

V = outimg(:,:,3);
%figure, imshow(V), title('Filtered Image');
H = imhist(V);
c = cumsum(imhist(outimg(:,:,3)));

V = uint8(V*255);

%bar(H);
%bar(c);

% (3) transforming the intensity values in V to occupy the full range 
% 0..255 in a new image W so that the histogram
% of W is roughly “flat"
[x, y, ~] = size( img );
totalPixels = x*y;
256/totalPixels;

for i = 1:x
    for j = 1:y
        W(i,j) = max(0, ((256/totalPixels)*c(V(i,j)+1))-1);
    end
end

H2 = imhist(uint8(W));
%bar(H2);

%(4) combining the original H and S channels with the W image to
% create a new color image, which is then converted to an RGB color 
% output image (using hsv2rgb)
W = W/255;
outimg(:,:,3) = W; 
outimg = hsv2rgb(outimg);
%figure, imshow(outimg), title('Filtered Image');

end

