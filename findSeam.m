function S = findSeam( I )
%takes an input color image I and returns the horizontal seam S

%rotate input image
J = permute(I, [2 1 3]);

%create grayscale image from input image of type double
E = rgb2gray( J );

%compute the gradient magnitude matrix of the grayscale image
E = imgradient(E);

S = horizontal_seam(E);

% Rotate figure back and show output
% J = permute(I, [2 1 3]);
% figure, imshow(J);

end

