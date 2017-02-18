function [ C1,C2,C3 ] =ReadColorVals( folderLoaction,n )
C1= zeros(n,1, 'double');
C2= zeros(n,1, 'double');
C3= zeros(n,1, 'double');
folderImagesLoaction=strcat(folderLoaction,'\*.jpg');
imagefiles = dir(folderImagesLoaction);
nfiles = length(imagefiles);
for i=1:nfiles
    currentFileName = imagefiles(i).name;
    currentFileName = strcat(folderLoaction,'\', currentFileName); 
    Ix = imread(currentFileName);
    % YCBCR========================
    IYCBCR = rgb2ycbcr(Ix);
    Y = uint32(IYCBCR(:, :, 1));
    Cb = uint32(IYCBCR(:, :, 2));
    Cr = uint32(IYCBCR(:, :, 3));
    % HSV========================
    IHSV = rgb2hsv(Ix);
    H = IHSV(:, :, 1);
    S = IHSV(:, :, 2);
    V = IHSV(:, :, 3);
    % RGB========================
    R = Ix(:, :, 1);
    G = Ix(:, :, 2);
    B = Ix(:, :, 3);
    % La*b*========================
    Ilab = rgb2lab(Ix);
    L =  double(Ilab(:, :, 1));
    a =  double(Ilab(:, :, 2));
    b =  double(Ilab(:, :, 3));
    % XYZ========================
    Ixyz = rgb2xyz(Ix);
    X =  double(Ixyz(:, :, 1));
    YY =  double(Ixyz(:, :, 2));
    Z =  double(Ixyz(:, :, 3));
    %============YDbDr
    IYDbDr = colorspace('YDbDr<-rgb', Ix);
    YD = double(IYDbDr(:, :, 1));
    Db = double(IYDbDr(:, :, 2));
    Dr = double(IYDbDr(:, :, 3));
    %============YDbDr
    IYPbPr = colorspace('YPbPr<-rgb', Ix);
    YP =  double(IYPbPr(:, :, 1));
    Pb =  double(IYPbPr(:, :, 2));
    Pr =  double(IYPbPr(:, :, 3));
    %============YDbDr
    IYUV = colorspace('YUV<-rgb', Ix);
    YU = double(IYUV(:, :, 1));
    UU = double(IYUV(:, :, 2));
    VV = double(IYUV(:, :, 3));
    I = rgb2gray(Ix);
    %binarize usin threshold
    level = graythresh(I);
    BW = imbinarize(I, level);
    %get complement image
    
    %count the total pixel of the object
    totalPixel = sum(BW(:));
    
    Ypixel = sum(Y(:));
    Cbpixel = sum(Cb(:));
    Crpixel = sum(Cr(:));
    Hpixel = sum(H(:));
    Spixel = sum(S(:));
    Vpixel = sum(V(:));
    Rpixel = sum(R(:));
    Gpixel = sum(G(:));
    Bpixel = sum(B(:)); 
    Lpixel = sum(L(:));
    apixel = sum(a(:));
    bpixel = sum(b(:)); 
    Xpixel = sum(X(:));
    YYpixel = sum(YY(:));
    Zpixel = sum(Z(:));
    YDpixel = sum(YD(:));
    Dbpixel = sum(Db(:));
    Drpixel = sum(Dr(:)); 
    YPpixel = sum(YD(:));
    Pbpixel = sum(Db(:));
    Prpixel = sum(Dr(:));
    YUpixel = sum(YU(:));
    UUpixel = sum(UU(:));
    VVpixel = sum(VV(:));
    Yavg = Ypixel / totalPixel;
    Cbavg = Cbpixel / totalPixel;
    Cravg = Crpixel / totalPixel;
    Havg = Hpixel / totalPixel;
    Savg = Spixel / totalPixel;
    Vavg = Vpixel / totalPixel;
    Ravg = Rpixel / totalPixel;
    Gavg = Gpixel / totalPixel;
    Bavg = Bpixel / totalPixel; 
    Lavg = Lpixel / totalPixel;
    aavg = apixel / totalPixel;
    bavg = bpixel / totalPixel; 
    Xavg = Xpixel / totalPixel;
    YYavg = YYpixel / totalPixel;
    Zavg = Zpixel / totalPixel;
    YDavg = YDpixel / totalPixel;
    Dbavg = Dbpixel / totalPixel;
    Dravg = Drpixel / totalPixel;
    YPavg = YPpixel / totalPixel;
    Pbavg = Pbpixel / totalPixel;
    Pravg = Prpixel / totalPixel;
    YUavg = YUpixel / totalPixel;
    UUavg = UUpixel / totalPixel;
    VVavg = VVpixel / totalPixel;
    %if Ravg<255
    C1(i,1)=YUavg;
   % end;
    %if Gavg<255
    C2(i,1)=Dbavg;
    %end;
    if Bavg<255
    C3(i,1)=Bavg;
    end;
    
end;
end

