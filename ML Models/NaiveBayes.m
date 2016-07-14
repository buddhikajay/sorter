inputs  =[Energy;Entropy;Contrast;Correation;Filled; Box];
mat=vec2mat((inputs)',6);
NBModel1 =  fitNaiveBayes(mat,Val);
NBModel1.ClassLevels % Display the class order
NBModel1.Params;
NBModel1.Params{1};
inputs1  =[Energy1;Entropy1;Contrast1;Correation1;Filled1; Box1];
mat1=vec2mat((inputs1)',6);
label = predict(NBModel1,mat1);
data=[(label),Val1];
hist(data);
legend('predicted','actual');
title('NaiveBayes');
saveas(gcf,'NaiveBayes.png');
bayeserrors =sum(abs(Val1-label));
display('Percentage=');
display((bayeserrors/length(Val1))*100);