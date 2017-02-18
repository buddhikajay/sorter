function [ W] = getWeights( LC1,LC2,SC1,SC2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
nL=max([length(LC1),length(LC2)]);
nS=max([length(SC1),length(SC2)]);
targetL=ones(nL,1);
targetS=-1*ones(nS,1);
target=[targetL;targetS];
InputL=[LC1.*LC1,LC2.*LC2,LC1.*LC2];
InputS=[SC1.*SC1,SC2.*SC2,SC1.*SC2];
Input=[InputL;InputS];
W=LDA(double(Input),target);
end

