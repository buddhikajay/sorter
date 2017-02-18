 	
function rgbImage = BackgroundRemove(inImg)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
R = inImg(:, :, 1);
G = inImg(:, :, 2);
B = inImg(:, :, 3);
I = rgb2gray(inImg);
%binarize usin threshold
level = graythresh(I);
BW = imbinarize(I, level);
%get complement image
imComp = imcomplement(BW);
rOut = uint8(imComp) .* R;
gOut = uint8(imComp) .* G;
bOut = uint8(imComp) .* B;
rgbImage = cat(3, rOut, gOut, bOut);
end

