file = 'E:\matlabworkspace\finalfypdataset\leafdata.xlsx';
sheet = 1;
srcFiles = dir('E:\test\*.png');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('E:\test\',srcFiles(i).name);
    Ix = imread(filename);
    %color space conversion
    IYCBCR=rgb2ycbcr(Ix);
    % split the image in to chanel
    Y = IYCBCR(:,:,1); % Y channel
    Cb = IYCBCR(:,:,2); % Cb channel
    Cr = IYCBCR(:,:,3); % Cr channel
    %convert to grayscale image
    I = rgb2gray(Ix);
    %binarize usin threshold
    BW = imbinarize(I,0.5);
    %get complement image
    IMComp = imcomplement(BW);
    %count the total pixel of the object
    totalPixel=sum(IMComp(:));
        %replace rgb object
        YM=uint8(IMComp).*Y;
        CbM=uint8(IMComp).*Cb;
        CrM=uint8(IMComp).*Cr;
        %A=cat(3,uint8(YM),uint8(CbM),uint8(CrM));
        %B=ycbcr2rgb(A);
        %figure,imshow(B);
        %sum of Y
        Ypixel=sum(YM(:));
        %sum of Cb
        Cbpixel=sum(CbM(:));
        %sum of Cr
        Crpixel=sum(CrM(:));
        %count avg of Y
        Yavg=Ypixel/totalPixel;
        %count avg of Cb
        Cbavg=Cbpixel/totalPixel;
        %count avg of Cr
        Cravg=Crpixel/totalPixel;
        %append excel sheet
        xlsappend(file,{Yavg,Cbavg,Cravg},sheet)

end

