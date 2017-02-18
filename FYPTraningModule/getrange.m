function [ c1Range,c2Range ,totRange] = getrange( Class1,Class2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
h1=histfit(Class1);
 hold on
h2=histfit(Class2);
delete(h1(1));
delete(h2(1));
tx1=get(h1(2),'XData');
tx2=get(h2(2),'XData');
c1Range=max(tx1)-min(tx1);
c2Range=max(tx2)-min(tx2);
totRange=max([tx1,tx2])-min([tx1,tx2]);
end

