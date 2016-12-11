function S = findSeamCollective( I1, I2 )
%Takes an input color image I and returns the horizontal seam S

% Rotate input image
J1 = permute(I1, [2 1 3]);
J2 = permute(I2, [2 1 3]);

% Create grayscale image from input image of type double, compute the
% gradient magnitude matrix of the grayscale image
E1 = imgradient(rgb2gray( J1 ));
E2 = imgradient(rgb2gray( J2 ));

% Find the minimum energy of both images at once
SC = horizontalSeamCollective( E1, E2 );

% alternatively, can find the minimum energy of both seams independently
% then pick the seam with the lowest energy in the other image
S1 = horizontal_seam( E1 );
S2 = horizontal_seam( E2 );

[~, c] = size(E1);
sum1on2 = 0;
sum2on1 = 0;
sumC = 0;
for i = 1:c
%     sum1on2 = sum1on2 + E2(i,S1(i)) + E1(i,S1(i));
%     sum2on1 = sum2on1 + E1(i,S2(i)) + E2(i,S2(i));
%     sumC = sumC + E1(i,SC(i)) + E2(i,SC(i));
    sum1on2 = sum1on2 + E2(S1(i),i) + E1(S1(i),i);
    sum2on1 = sum2on1 + E1(S2(i),i) + E2(S2(i),i);
    sumC = sumC + E1(SC(i),i) + E2(SC(i),i);
end

[~,minSeam] = min([sum1on2,sum2on1,sumC]);
if minSeam == 1
    S = S1;
end
if minSeam == 2
    S = S2;
end
if minSeam == 3
    S = SC;
end
% Rotate figure back and show output
% J = permute(I, [2 1 3]);
% figure, imshow(J);

end

