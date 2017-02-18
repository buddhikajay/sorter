function  WriteFile( Th )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
fid=fopen('C:\Users\YASARA\Desktop\FYPTraningModule\MyFile.txt','w');
fprintf(fid, '%f \n', [Th]');
fclose(fid);
end

