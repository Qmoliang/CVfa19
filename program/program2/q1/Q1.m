me = imread('me.JPG');
UFtower = imread('tower.png');%tower.png
CISE = imread('cise.JPG');

new_face = bilateral_Filter(me,128,30,30,3);
new_cen_tower = bilateral_Filter(UFtower,128,30,30,3);
new_fries_cise = bilateral_Filter(CISE,128,30,30,3);
%% Combined domain and range filtering 
% INPUT: image - the original color image
%        dim - input size of image
%        sigma_r
%        sigma_d
%        channel
% OUT:an image after bilateral filtering
%%
function OUTPUT = bilateral_Filter(image, dim, sigma_d, sigma_r, channel)
    n=5;
    
    image = imresize(image,[dim,dim]);
    padding0 = zeros(dim+n-1,dim+n-1,channel);
    
    pad = (n-1)/2;
    
    padding0(pad+1:dim+pad,pad+1:dim+pad,:) = image;
    outputimage = zeros(dim,dim,channel);
    
    for i = pad+1:dim+pad
        for j = pad+1:dim+pad
            sum_of_f = zeros(1,channel);
            sum_of_weight = zeros(1,channel);
            for k = i-pad:i+pad
                for l = j-pad:j+pad
                    domain_kernel = exp(-((i-k).^2+(j-l).^2)/(2*sigma_d.^2));%calculate d
                    range_kernel = zeros(1,3);
                    w = zeros(1,3);
                    for c = 1:channel 
                        range_kernel(c) = exp(-(padding0(k,l,c)-padding0(i,j,c)).^2/(2*sigma_r.^2));%calculate r
                        w(c) = domain_kernel * range_kernel(c);
                        sum_of_f(c) = sum_of_f(c) + padding0(k,l,c) * w(c);
                        sum_of_weight(c) = sum_of_weight(c) + w(c);
                    end
                end
            end
            
            for k = 1:channel
                outputimage(i-pad,j-pad,k) = sum_of_f(k) / sum_of_weight(k);
            end
            
        end
    end
    
    outputimage = uint8(outputimage);
    OUTPUT = outputimage;
    
    figure;
    subplot(1,2,1);imshow(image);title('origin image');
    subplot(1,2,2);imshow(OUTPUT);title('image after convolution');
    
end