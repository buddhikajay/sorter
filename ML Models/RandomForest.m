 trainData2 = [Energy;Entropy;Contrast;Correation;Filled; Box;Val];
kk1= reshape(trainData2 ,[398,7]);
features = kk1(:,(1:6));
classLabels = kk1(:,7);
for j = 1:50
% How many trees do you want in the forest? 
err=[];
nTrees = j;
 
% Train the TreeBagger (Decision Forest).
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');
trainData3 = [Energy1;Entropy1;Contrast1;Correation1;Filled1; Box1];
kk1= reshape(trainData3 ,[500,6]);
for i = 1:500
newData1(i) = str2double(B.predict([kk1(i,1),kk1(i,2),kk1(i,3),kk1(i,4),kk1(i,5),kk1(i,6)]));
end;
data=[newData1;(Val1)'];
hist(data');
legend('predicted','actual');
title('Random Forest');
saveas(gcf,'RandomForest.png');
saveas(gcf,'RandomForest.png');
foresterrors =sum(abs(Val1-label));
display('Percentage=');
display((foresterrors/length(Val1))*100);