function  WriteFileWeights(W )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
fid=fopen('C:\Users\YASARA\Desktop\FYPTraningModule\MyWeights.txt','w');
fprintf(fid, '%f %f %f %f\n', W(1,:));
fclose(fid);
end


