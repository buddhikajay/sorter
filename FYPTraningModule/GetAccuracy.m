function [ accuracy,Thh] = GetAccuracy(D1,D2)

Mxx=max(max(D1),max(D2));
Min=min(min(D1),min(D2));
%hh=3.49*std([D1,D2])*power(length(D1)+length(D2),-1/3);
%bin=double((Mxx-Min)/255);
bin1=3.49*std([D1])*power(length(D1),-1/3); %Scott suggested using the Gaussian density as a reference standard
bin2=3.49*std([D2])*power(length(D2),-1/3); %Scott suggested using the Gaussian density as a reference standard
bin=min(bin1,bin2);
pd1 = fitdist(D1, 'Normal');
pd2 = fitdist(D2, 'Normal');
x_values = Min:bin:Mxx; %---------Color range-
y1 = normpdf( x_values,pd1.mu,pd1.sigma);
y2 = normpdf(x_values,pd2.mu,pd2.sigma);
set(gcf, 'Visible', 'off');
h=plot(x_values,y1,'LineWidth',2);hold on
h=plot(x_values,y2,'LineWidth',2);
saveas(gcf,'Stat.png');

index=Min;
i=1;
FalsePositive=zeros(1,length(y1)-1);
FalseNegative=zeros(1,length(y1)-1);
Th=zeros(1,length(y1)-1);
while index<=Mxx
x_values1 = index:bin:Mxx; %For lower pd1
x_values2 = Min:bin:index; %For higher pd1
Mx = max(min(sort(D1)), min(sort(D2)));
if Mx == min(sort(D2))
    %x_values2 = 0:1:index;%For D2
    yy1 = pdf(pd2, x_values2);
    errorProb1 = sum(yy1);
    %x_values1 = index:1:255;%For  D1
    yy2 = pdf(pd1, x_values1);
    errorProb2 = sum(yy2);
    FalsePositive(i) = errorProb2*100*bin;
    FalseNegative(i) = errorProb1*100*bin;
	Th(i)=index;
    i=i+1;
else
    yy1 = pdf(pd1, x_values2);
    errorProb1 = sum(yy1);
    yy2 = pdf(pd2, x_values1);
    errorProb2 = sum(yy2);
    FalsePositive(i) = errorProb1*100*bin;
    FalseNegative(i) = errorProb2*100*bin;
	Th(i)=index;
    i=i+1;
end;
index=index+bin;
end;
[~,Threshod]=min((FalsePositive+FalseNegative)/2);
Thh=Th(Threshod)
accuracy=100-min((FalsePositive+FalseNegative)/2);
end

