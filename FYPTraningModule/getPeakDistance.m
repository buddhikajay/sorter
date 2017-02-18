function [ dist ] = getPeakDistance( Class1,Class2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
h1=histfit(Class1);
 hold on
h2=histfit(Class2);
delete(h1(1));
delete(h2(1));
ty1=get(h1(2),'YData');
ty2=get(h2(2),'YData');
tx1=get(h1(2),'XData');
tx2=get(h2(2),'XData');
[tf, index2] = ismember(max(ty2), ty2);
[tf, index1] = ismember(max(ty1), ty1);
dist=abs(tx1(index1)-tx2(index2));

end

