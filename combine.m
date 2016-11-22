function cImg = combine( im_input1, im_input2 )
    
    h1 = fix(size(im_input1,2)/2);
    h2 = fix(size(im_input2,2)/2);
    I1 = im_input1(:,1:h1,:);
    I2 = im_input2(:,h2+1:end,:);
    cImg = cat(2, I1(:,1:h1,:), I2(:,h2:end,:));
    %cImg1 = I1;
    %cImg2 = I2;
end