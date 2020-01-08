%% Function to reconstruct image from Laplacian pyramid
% Input: Laplacian pyramid of an image
% Output: Reconstructed image
function [im] = reconstructImage(lpyr)
    img = lpyr{1,1};
    for i=2:size(lpyr,2)
        uimg = upsampleImg(img);
        simg = smoothenImg(uimg, 'laplace');
        img = simg + lpyr{1,i};
    end
    im = img;
end



