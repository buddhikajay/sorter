inputs  =[Energy;Entropy;Contrast;Correation;Filled; Box];
AA= reshape(inputs,[6,398]);
targets = [Val];
AA1= reshape(targets,[1,398]);
 k  =[Energy1;Entropy1;Contrast1;Correation1;Filled1; Box1];
kk1= reshape(k,[6,500]);
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

[net,tr] = train(net,AA,AA1);

outputst = net(kk1);

for i = 1:length(outputst)
    t=outputst(i);
if t > 0.5
outputs(i)=1;
elseif t < 0.5
outputs(i)=0;
end;
end;
data=[(outputs)',Val1];
hist(data);
title('Neural Network');
legend('predicted','actual');
saveas(gcf,'NeuralNetwork.png');
neuralerrors =sum(abs(Val1-label));
display('Percentage=');
display((neuralerrors/length(Val1))*100);