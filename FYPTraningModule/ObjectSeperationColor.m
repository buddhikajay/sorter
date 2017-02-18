function [k,outFile] = ObjectSeperationColor(folderLoaction, Option, sizeTh)
%   Detailed explanation goes here
outFile='';
%folderLoaction = 'C:\Users\YASARA\Desktop\FYPTraningModule\testIn\*.jpg';
folderImagesLoaction=strcat(folderLoaction,'\*.jpg');
imagefiles = dir(folderImagesLoaction);
nfiles = length(imagefiles);
k = 1;
for ii = 1:nfiles
    currentfilename = imagefiles(ii).name;
    currentfilename = strcat(folderLoaction,'\', currentfilename);
    imRGB = imread(currentfilename);
    imRGB = BackgroundRemove(imRGB);
    I = rgb2gray(imRGB);
    %Otsu thresholding
    level = graythresh(I);
    BW = im2bw(I, level);
    [B, L, ~, A] = bwboundaries(BW);
    for idy = 2:length(B)
        boundary = B{idy};
       
        imCroped = imRGB(...
        min(boundary(:, 1)):max(boundary(:, 1)), ... %the rows
          min(boundary(:, 2)):max(boundary(:, 2)), ... %the cols
          :);
        imSize = size(imCroped);
        if (imSize(1) * imSize(2) > sizeTh)
            imName = strcat(int2str(k), '.jpg');
            if Option == 'L'
                imName = strcat('C:\Users\YASARA\Desktop\FYPTraningModule\testOutLeaf\', imName);
                outFile='C:\Users\YASARA\Desktop\FYPTraningModule\testOutLeaf';
            elseif Option == 'S'
                imName = strcat('C:\Users\YASARA\Desktop\FYPTraningModule\testOutStem\', imName);
                outFile='C:\Users\YASARA\Desktop\FYPTraningModule\testOutStem';
            else
                imName = strcat('C:\Users\YASARA\Desktop\FYPTraningModule\testOut\', imName);
                outFile='C:\Users\YASARA\Desktop\FYPTraningModule\testOut';
            end
            k = k + 1;
            %imBackgroundreomved = BackgroundRemove(imCroped);
            imwrite(imCroped, imName);
        end;
        end;
    
end;

%ReadColorVals( outFile,k );
end
