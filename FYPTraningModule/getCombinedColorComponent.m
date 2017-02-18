function [ Lout,Sout ] = getCombinedColorComponent( W,L1,L2,S1,S2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Lout= [W(1,1)*L1.*L1+W(1,3)*L2.*L2+W(1,3)*L1.*L2+W(1,4)];
Sout= [W(1,1)*S1.*S1+W(1,3)*S2.*S2+W(1,3)*S1.*S2+W(1,4)];

end

