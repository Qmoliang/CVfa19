%% Function to upsample an image
function [uimg] = upsampleImg(img)
    [imgRows, imgCols, imgDim] = size(img);
    uimg = zeros(imgRows*2, imgCols*2, imgDim);
    
    iCounter = 1;
    for i=1:2:imgRows*2
        jCounter = 1;
        for j=1:2:imgCols*2
            uimg(i,j,:) = img(iCounter,jCounter,:);
            if(jCounter<=imgCols)
                jCounter = jCounter + 1;
            end
        end
        if(iCounter <= imgRows)
            iCounter = iCounter + 1;
        end
    end
    uimg = im2double(uimg);
end


