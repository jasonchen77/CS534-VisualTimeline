function S = horizontal_seam(I)
%takes an image and finds the (one) optimal horizontal seam, returning a
%vector of length equal to the number of columns in I such that each
%entry in vector S is an integer-valued row number indicating which
%pixel in that column should be removed

[rows, cols] = size(I);

%calculate restriction of rows to search for minimum seam
restriction = rows*0.2; %only search pixels in middle 20% of image
top = (rows+restriction)/2;
bottom = (rows-restriction)/2;

%cut image down to restriction and recalculate size
I = I(bottom:top, :);
[rows, cols] = size(I);

%pad top and bottom row with inf values so that they will never be chosen
%as part of a seam
pad = Inf*ones([1,cols]);
I = [pad;I;pad];

%store cumulative energy values and pointers
%careful - size has now been adjusted to accommodate top and bottom padding
%rows
cumenergies = Inf*ones(size(I));
pointers = zeros(size(I));

%First pass: L->R, fill the DP matrix
%careful - cumenergies will have an infinity value on top and on bottom
cumenergies(:,1) = I(:,1);
for c=2:cols
    for r=2:rows+1
        opts = [cumenergies(r-1,c-1);cumenergies(r,c-1);cumenergies(r+1,c-1)];
        %minenergy holds the minimum energy value of the next three pixels
        %minrow identifies whether it's the (r,c-1), (r,c), (r,c+1) pixel
        [minenergy, minrow] = min(opts);
        %assign appropriate cumenergies value
        cumenergies(r,c) = I(r,c)+minenergy;
        %assign appropriate pointer value
        if (minrow == 1) 
            prevrow = r-1;
        end
        if (minrow == 2)
            prevrow = r;
        end
        if (minrow == 3)
            prevrow = r+1;
        end
        pointers(r,c) = prevrow;
    end
end

%Second pass: L->R, choose optimal seam
S = zeros(1, cols);
[~, startseamrow] = min(cumenergies(:,cols));
r = startseamrow;
%note that row values will now be off-by-one in comparison to the original
%image due to the padding row on top
for c = cols:-1:1
    S(c) = r-1;
    r = pointers(r,c);
end

%add offset from bottom to seam to match original input image
S = S + bottom;

end

