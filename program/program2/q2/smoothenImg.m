%% Function to smoothen an image based on a binomial kernel
function [simg] = smoothenImg(img, type)
    X = 1/16 * [1, 4, 6, 4, 1];
    if(strcmp(type,'gauss'))
        H = X' * X;
    elseif(strcmp(type,'laplace'))
        H = 4 * (X' * X);
    end
    simg = convn(img, H, 'same');
    simg = im2double(simg);
end



