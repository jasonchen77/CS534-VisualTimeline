function cImg = combine( im_input1, im_input2 )
    
    % cut the images in half
    h1 = fix(size(im_input1,2)/2);
    h2 = fix(size(im_input2,2)/2);
    I1 = im_input1(:,1:h1,:);
    I2 = im_input2(:,h2+1:end,:);
    
    % combine the 2 images
    cImg = cat(2, I1, I2);

end

