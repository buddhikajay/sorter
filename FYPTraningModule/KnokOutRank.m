function [ Rank ] = KnokOutRank( Class1,Class2 )
Class1=reshape(Class1,[length(Class1),1]);
Class2=reshape(Class2,[length(Class2),1]);
Class1=Class1';
Class2=Class2';
M1=[mean(Class1')];
M2=[mean(Class2')];
numberOfElements1 = size(Class1,1);
numberOfClasses = 2;
squreSum1=zeros([numberOfElements1,numberOfElements1]);
for i=1:numberOfElements1
	squreSum1=squreSum1+( Class1(:,i) - M1')*( Class1(:,i) - M1')';
end;
E1=(squreSum1)/numberOfElements1;%variance
numberOfElements2 = size(Class2,1);
squreSum2=zeros([numberOfElements2,numberOfElements2]);
for i=1:numberOfElements2
	squreSum2=squreSum2+( Class2(:,i) - M2')*( Class2(:,i) - M2')';
end;
E2=(squreSum2)/numberOfElements2;%variance
EC=(E1+E2)/numberOfClasses;%class variance
M=(M1+M2)/numberOfClasses;
ES=(((M1-M)'*(M1-M))+((M2-M)'*(M2-M)))/2;%Mean varinace
Rank=trace(ES*inv(EC));
end
