%Test version

function [ seam ] = seamFindingTest(inImg)

I = inImg;

% Get energy
J = rgb2gray(I);
E = imgradient(J);

%
[seam, Max] = vertical_seam(E);
%

%-----Ignore, just trying out things-----
% n = floor(size(inImg, 2)/2)-20;
% I = inImg;
% 
% h = fspecial('average', [3,3]);
% for c = n:1:n+40
%     cAvg = imfilter(I(:,n:n+40,:), h);
% end
% 
% I(:,n:n+40,:) = cAvg;
% 
% outImg = I;
%-----------------------------------------------

end


%---Find most noticeable seam-----
function [S, MImg] = vertical_seam(I)

I = permute(I, [2 1 3]);

[row, col] = size(I);
M = I;

% forward pass
for c = 2:col
    for r = 1:row
        if r-1<1
            M(r,c) = I(r,c) + max([M(r,c-1), M(r+1,c-1)]);           
        elseif r+1>row
            M(r,c) = I(r,c) + max([M(r-1,c-1), M(r,c-1)]);
        else
            M(r,c) = I(r,c) + max([M(r-1,c-1), M(r,c-1), M(r+1,c-1)]);
        end
    end
end

MImg = M;

[maxVal, maxI] = max(M(:,col));

seamHor = zeros(1,col);
seamHor(1,col) = maxI;

r = maxI;
v = maxVal;

% backward pass
for c = col:-1:2
        if r-1<1
            [mV, mI] = max([M(r,c-1), M(r+1,c-1)]);
            v = v + mV;
            seamHor(1,c-1) = r + (mI - 1);
            r = r + (mI - 1);          
        elseif r+1>row
            [mV, mI] = max([M(r-1,c-1), M(r,c-1)]);
            v = v + mV;
            seamHor(1,c-1) = r + (mI - 2);
            r = r + (mI - 2);
        else
            [mV, mI] = max([M(r-1,c-1), M(r,c-1), M(r+1,c-1)]);
            v = v + mV;
            seamHor(1,c-1) = r + (mI - 2);
            r = r + (mI - 2);
        end
end

I = seamHor;
S = permute(I, [2 1 3]);

end
%-----------------------------------