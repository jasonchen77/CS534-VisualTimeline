function S = findSeamCollective( I1, I2 )
%Takes two input images I and returns the horizontal seam S

% Rotate input images
J1 = permute(I1, [2 1 3]);
J2 = permute(I2, [2 1 3]);

% Create grayscale image from input image of type double, compute the
% gradient magnitude matrix of the grayscale image
E1 = imgradient(rgb2gray( J1 ));
E2 = imgradient(rgb2gray( J2 ));

% Find the minimum energy of both images at once
S = horizontalSeamCollective( E1, E2 );

end

