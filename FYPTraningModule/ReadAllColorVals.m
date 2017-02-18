function [ C ] =ReadAllColorVals( folderLoaction,n )
C= zeros(n,1,24, 'double');

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
    YPpixel = sum(YP(:));
    Pbpixel = sum(Pb(:));
    Prpixel = sum(Pr(:));
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
    C(i,1,1)=Yavg;
    C(i,1,2)=Cbavg;
    C(i,1,3)=Cravg;
    C(i,1,4)=Havg;
    C(i,1,5)=Savg;
    C(i,1,6)=Vavg;
    C(i,1,7)=Ravg;
    C(i,1,8)=Gavg;
    C(i,1,9)=Bavg;
    C(i,1,10)=Lavg;
    C(i,1,11)=aavg;
    C(i,1,12)=bavg;
    C(i,1,13)=Xavg;
    C(i,1,14)=YYavg;
    C(i,1,15)=Zavg;
    C(i,1,16)=YDavg;
    C(i,1,17)=Dbavg;
    C(i,1,18)=Dravg;
    C(i,1,19)=YPavg;
    C(i,1,20)=Pbavg;
    C(i,1,21)=Pravg;
    C(i,1,22)=YUavg;
    C(i,1,23)=UUavg;
    C(i,1,24)=VVavg;    
end;
end

