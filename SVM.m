%Basic SVM implementation without doing the accuracy evaluation part
filename='E:\matlabworkspace\finalfypdataset\trainingDataSet.xlsx';
T = readtable(filename,'ReadRowNames',true);
%disp(T);
SVMModel = fitcsvm(T,'Label');
classOrder = SVMModel.ClassNames;
%disp(classOrder);
filename2='E:\matlabworkspace\finalfypdataset\testDataSet.xlsx';
TestTB = readtable(filename2,'ReadRowNames',true);
%disp(TestTB);
label = predict(SVMModel,TestTB);
disp(label);
