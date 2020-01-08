% Script to blend hand and eye image

% Read images
img1 = imread('me.jpg');
img2 = imread('myhand.jpg');
% Resize images to 256x256
img1 = imresize(img1, [256,256]);
img2 = imresize(img2, [256,256]);
% Load mask
mask = zeros(size(img1));
mask(:, :, :) = imread('maskeyeforme.jpg');
mask = imresize(mask, [256, 256]);


% Generate Laplacian pyramid for both the images
lpyr1 = getPyr(img1, 'laplace', 6);
lpyr2 = getPyr(img2, 'laplace', 6);


% Generate blended laplacian pyramid and reconstruct image
bpyr = blendImgs(lpyr1, lpyr2, mask);
rimg = reconstructImage(bpyr);
figure, imshow(uint8(rimg))

%% Function to blend images based on laplacian pyramids and mask
function [bpyr] = blendImgs(lpyr1, lpyr2, mask)
    bpyr = cell(size(lpyr1));
    gpyr = getPyr(mask, 'gauss', 6);
    gpyrforshow = getPyr(mask, 'laplace', 6);
    for i=1:size(lpyr1,2)
        % Uncomment this part to show Gaussian pyramid of mask
        % figure, imshow(uint8(gpyr{1,i}))
        
        % Get weighted average
        Lapi = lpyr1{1,i} .* gpyr{1, size(gpyr,2)-i+1} ...
             + (255*ones(size(gpyr{1, size(gpyr,2)-i+1})) ...
             - gpyr{1, size(gpyr,2)-i+1}) .* lpyr2{1,i};
        bpyr{1,i} = Lapi;
        % show blended pyramid
        % figure, imshow(uint8(Li))
        % show pyramid without casting to uint8
        % figure, imshow(Li)
    end
end

