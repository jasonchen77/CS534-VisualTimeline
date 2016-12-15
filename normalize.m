function [ normalized ] = normalize( original )
% Given an input image, normalize all pixel values in the image

% Normalizing values   
    l_R = original(:,:,1);
    l_G = original(:,:,2);
    l_B = original(:,:,3);

    minM = min(min(l_R));
    maxM = max(max(l_R));
    normBWD = (l_R - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_R = epNormBWD;

    minM = min(min(l_G));
    maxM = max(max(l_G));
    normBWD = (l_G - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_G = epNormBWD;
    
    minM = min(min(l_B));
    maxM = max(max(l_B));
    normBWD = (l_B - minM)./(maxM - minM);
    epNormBWD = normBWD + 0.001;
    l_B = epNormBWD;
    
    normalized = cat(3, l_R, l_G, l_B);

end

