%% Function to get a a cell array consisting of pyramid of images
% Input1: image(color/grayscale)
% Input2: type: gauss/laplace
% Input3: number of levels in pyramid
% Output: pyramid of images in a cell array
function [pyr] = getPyr(img, type, numLevels)
    % Create cell array pyr of size numLevels
    gpyr = cell(1,numLevels);
    lpyr = cell(1,numLevels);
    
    % Convert image to double to prevent loss of information
    if(isa(img, 'uint8'))
        img = im2double(img);
    end
    
    % Gaussian Pyramid
    if(strcmp(type,'gauss'))
        gpyr{1,1} = img;
        for i=2:numLevels
            simg = smoothenImg(img, type);
            dimg = downsampleImg(simg);
            gpyr{1,i} = dimg;
            img = dimg;
        end
        pyr = gpyr;
        
        % show images
        % for i=1:numLevels
        %     figure, imshow(gpyr{1,i})
        % end
        
    
    % Laplacian Pyramid    
    elseif(strcmp(type,'laplace'))
        % First, generate Gaussian pyramid
        gpyr{1,1} = img;
        for i=2:numLevels
            simg = smoothenImg(img, 'gauss');
            dimg = downsampleImg(simg);
            gpyr{1,i} = dimg;
            img = dimg;
        end
         clc;figure;
        % show images
        j=1;
         for i=1:numLevels
             if(i==2*j)
                subplot(2,3,j);imshow(gpyr{1,i});title('gpyr');
                j=j+1;
             end
             %figure, imshow(lpyr{1,i})
         end
        % Use Gaussian pyrmaid for constructing Laplacian pyramid
        img = gpyr{1,numLevels};
        lpyr{1,1} = img;
        for i=2:numLevels
            uimg = upsampleImg(img);
            simg = smoothenImg(uimg, type);
            lpyr{1,i} = gpyr{1,numLevels-i+1} - simg;
            img = gpyr{1,numLevels-i+1};
        end
        pyr = lpyr;
        
        k=1;
        % show images
        for m=1:numLevels
             if(m==2*k)
             subplot(2,3,7-k);imshow(lpyr{1,m});title('lpyr');
             k=k+1;
             end
             %figure, imshow(lpyr{1,i})
        end
    end
end

