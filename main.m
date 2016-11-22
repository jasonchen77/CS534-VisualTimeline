clear;

img1 = imread('gct-inside-2-before.0.jpg');
img2 = imread('gct-inside2-after.0.jpg');
img1D = im2double(img1);
img2D = im2double(img2);

%[cImg1, cImg2] = combine(img1D, img2D);
cImg = combine(img1D, img2D);
%output_image = zeros(size(img1,1), size(img1, 2), 3);

output_image = fBlend(img1D, img2D);

%output_image = fBlend(cImg, cImg);

imshow(output_image);