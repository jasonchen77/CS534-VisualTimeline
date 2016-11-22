function [ im_blended ] = blend( im_input1, im_input2 )
%BLEND Blends two images together via feathering
% Pre-conditions:
%     `im_input1` and `im_input2` are both RGB images of the same size
%     and data type
% Post-conditions:
%     `im_blended` has the same size and data type as the input images
    
    assert(all(size(im_input1) == size(im_input2)));
    assert(size(im_input1, 3) == 3);

    im_blended = zeros(size(im_input1), 'like', im_input1);

    %------------- YOUR CODE STARTS HERE -----------------
%     Ir1 = im_input1(:,:,1);
%     Ig1 = im_input1(:,:,2);
%     Ib1 = im_input1(:,:,3);
%     a1 = rgb2alpha(im_input1);
%     
%     Ir2 = im_input2(:,:,1);
%     Ig2 = im_input2(:,:,2);
%     Ib2 = im_input2(:,:,3);
%     a2 = rgb2alpha(im_input2);
%     
%     Irout = (a1.*Ir1 + a2.*Ir2)./(a1+a2);
%     Igout = (a1.*Ig1 + a2.*Ig2)./(a1+a2);
%     Ibout = (a1.*Ib1 + a2.*Ib2)./(a1+a2);
%     
%     im_blended = cat(3, Irout, Igout, Ibout);

    Ir1 = im_input1(:,:,1);
    Ig1 = im_input1(:,:,2);
    Ib1 = im_input1(:,:,3);
    a1 = rgb2alpha(im_input1);
    
    Ir2 = im_input2(:,:,1);
    Ig2 = im_input2(:,:,2);
    Ib2 = im_input2(:,:,3);
    a2 = rgb2alpha(im_input2);
    
    Irout = (a1.*Ir1 + a2.*Ir2)./(a1+a2);
    Igout = (a1.*Ig1 + a2.*Ig2)./(a1+a2);
    Ibout = (a1.*Ib1 + a2.*Ib2)./(a1+a2);
    
    im_blended = cat(3, Irout, Igout, Ibout);

    %------------- YOUR CODE ENDS HERE -----------------

end

function im_alpha = rgb2alpha(im_input, epsilon)
% Returns the alpha channel of an RGB image.
% Pre-conditions:
%     im_input is an RGB image.
% Post-conditions:
%     im_alpha has the same size as im_input. Its intensity is between
%     epsilon and 1, inclusive.

    if nargin < 2
        epsilon = 0.001;
    end
    
    %------------- YOUR CODE STARTS HERE -----------------
    BW = im2bw(im_input, 0);
    BW2= ~BW;
    bwd = bwdist(BW2, 'euclidean');
    minM = min(min(bwd));
    maxM = max(max(bwd));
    normBWD = (bwd - minM)./(maxM - minM);
    epNormBWD = normBWD + epsilon;
    im_alpha = epNormBWD;
    
    %------------- YOUR CODE ENDS HERE -----------------

end
