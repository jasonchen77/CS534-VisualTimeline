function [ im_1, im_2 ] = resize( im_1, im_2 )
%Given two input images, check the sizes of both and truncate one of the
%images to match the size of the smaller image if necessary

if ~all(size(im_1) == size(im_2))
    %ensure same number of cols
    if size(im_1,1) < size(im_2,1)
        m1 = size(im_1,1);
        im_2 = im_2(1:m1,:,:);
    end
    if size(im_1,1) > size(im_2,1)
        m1 = size(im_2,1);
        im_1 = im_1(1:m1,:,:);
    end
    %ensure same number of rows
    if size(im_1,2) < size(im_2,2)
        m2 = size(im_1,2);
        im_2 = im_2(:,1:m2,:);
    end
    if size(im_1,2) > size(im_2,2)
        m2 = size(im_2,2);
        im_1 = im_1(:,1:m2,:);
    end
end

end