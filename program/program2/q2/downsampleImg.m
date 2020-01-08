%% Function to downsample an image
function [dimg] = downsampleImg(img)
    dimg = img(1:2:end, 1:2:end, :);
end