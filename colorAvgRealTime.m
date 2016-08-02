%clear variables to release the camera and clear data from previous run
clearvars
%use ipcam. http://www.cnet.com/how-to/how-to-use-your-android-as-a-webcam/
cam = ipcam('http://192.168.43.1:8080/video')
%cam = webcam(1);

CrMax = 16;
CrMin = 240;
CbMax = 16;
CbMin = 240;

%infinite loop to grab frames from camera,analyze and display
while 1
    %clear variables of previous iteration
    clearvars -except cam CrMax CrMin CbMax CbMin
    
    %grab frame from webcam
    img = snapshot(cam);
    
    %get gray scale image
    I = rgb2gray(img);
    %binarize usin threshold
    BW = imbinarize(I,0.3);
    
    %find objects using boundries
    [B1,L1,N1,A1] = bwboundaries(BW,8,'holes');%8-connected neighborhood, 	
    %noholes - Search only for object (parent and child) boundaries. This can provide better performance.
    count=1;
    %iterate objects
    for idy = 2:length(B1)
        boundary1 = B1{idy};
        %crop the object and create a new image
        croped = img( ...
             min(boundary1(:,1)):max(boundary1(:,1)),... %the rows
             min(boundary1(:,2)):max(boundary1(:,2)),... %the cols
             :);
        
        
        %find dimentions of new image
        [x1,y1,z1] = size(croped);
        %ignore small objects
        if (x1 > 50 && y1 > 50)
            
            % get YCBCR channels
            IYCBCR=rgb2ycbcr(croped);
            Y = IYCBCR(:,:,1);
            Cb = IYCBCR(:,:,2); 
            Cr = IYCBCR(:,:,3);
            
            %get gray scale image
            gray = rgb2gray(croped);
            %binarize using threshold
            croped_BW = imbinarize(gray,0.3);
            %get complement image
            IMComp = imcomplement(croped_BW);
            %count the total pixel of the object
            totalPixel=sum(IMComp(:));
            
            %remove background
            %YcrCb==================
            YM=uint8(IMComp).*Y;
            CbM=uint8(IMComp).*Cb;
            CrM=uint8(IMComp).*Cr;
            
            %RGB==================
            R=uint8(IMComp).*croped(:,:,1);
            G=uint8(IMComp).*croped(:,:,2);
            B=uint8(IMComp).*croped(:,:,3);
            
            %calculate sum of color values in object
            Ypixel=sum(YM(:));
            Cbpixel=sum(CbM(:));
            Crpixel=sum(CrM(:));
            
            %get avarage value of each color component of the object
            Yavg=Ypixel/totalPixel
            Cbavg=Cbpixel/totalPixel
            Cravg=Crpixel/totalPixel
            
            %save average values in arrays
            YavgArray{count} =Yavg;
            CbavgArray(count) = Cbavg
            CravgArray(count) = Cravg;
            
            %save background remove RGB image
            imArray{count} = cat(3, R, G, B);
            count = count+1
            
            %find min max for Cr and Cb set limts for axis in graph
            if(CrMax<Cravg)
                CrMax=Cravg;
            end
            if(CbMax<Cbavg)
                CbMax=Cbavg;
            end
            if(CrMin>Cravg)
                CrMin=Cravg;
            end
            if(CbMin>Cbavg)
                CbMin=Cbavg;
            end
            
            
        end;
        
    end;
    count = count-1;
    
    %number of rows and columns in display window
    figureRows = ceil((count/3)+1);
    figureCols =3;
    
    %display original and binary image
    subplot(figureRows,figureCols,1),imshow(img);
    title('Original');
    subplot(figureRows,figureCols,2),imshow(BW);
    title('Binary');
    
    
    %plot the graph if objects detected
    if(count>0)
       
        subplot(figureRows,figureCols,3),plot(CravgArray,CbavgArray,'b.','MarkerSize',10);  %# Plot data set 2
        
        %add lables to data points
        a = [1:count]'; b = num2str(a); c = cellstr(b);
        dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
        text(CravgArray+dx, CbavgArray+dy, c);
        
        %lable axis
        xlabel('Cr') % x-axis label
        ylabel('Cb') % y-axis label
        
        %define limts for x and y axis
        xlim([CrMin-5 CrMax+5])
        ylim([CbMin-5 CbMax+5])
        
        %add title
        title('Mean values of Cr and Cb');
    end
    
    %disply objects saved in imArray
    for i=4:1:(count+3)    
        im = imArray{(i-3)};      
        subplot(figureRows,figureCols,i),subimage(im)
        title(i-3)    
    end
    
end
