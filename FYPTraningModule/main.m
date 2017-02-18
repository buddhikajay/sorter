fileID = fopen('Config.txt','r');
A=textscan(fileID, '%s');
k=A{1}(2);
th=str2num(k{1});
path1=A{1}(3);
path2=A{1}(4);
[kL,outFileL]=ObjectSeperationColor(path1{1},'L',th);
[kS,outFileS]=ObjectSeperationColor(path2{1},'S',th);
%[L1,L2,L3 ]=ReadColorVals( outFileL,kL );
%[S1,S2,S3 ]=ReadColorVals( outFileS,kS); 
%W=getWeights(L1,L2,S1,S2);
%[ Lout,Sout ]=getCombinedColorComponent(W,L1,L2,S1,S2);
%[ accuracy1,Th1]=GetAccuracy(double(L1),double(S1));
%[ accuracy2,Th2]=GetAccuracy(double(L2),double(S2));
%[ accuracy3,Th3]=GetAccuracy(double(L3),double(S3));
%WriteFile( Th1,Th2,Th3 );
%WriteFileWeights(W);
%[ accuracy,Th]=GetAccuracy(double(Lout),double(Sout));

LC=ReadAllColorVals( outFileL,kL );
SC=ReadAllColorVals( outFileS,kS); 
x = ones(1,24);
ISec = ones(1,24);
for n = 1:24
     cleanedLC=deleteoutliers(LC(:,:,n),0.5);
     cleanedSC=deleteoutliers(SC(:,:,n),0.5);
     [accuracy,InSect] = GetAccuracyHistFifNorm(cleanedLC,cleanedSC);
     [val,idx]=max(InSect(2,:));
     mxinterSect=InSect(1,idx);
     x(n) = accuracy;
     if length(mxinterSect)==0
         mxinterSect=0;
     end;
     ISec(n)=mxinterSect;
end
[maxVal1,Idx1]=max(x);
L1=LC(:,:,Idx1);
S1=SC(:,:,Idx1);
cleanedLC1=deleteoutliers(L1,0.5);
cleanedSC1=deleteoutliers(S1,0.5);
x(Idx1) = 0;
[maxVal2,Idx2]=max(x);
L2=LC(:,:,Idx2);
S2=SC(:,:,Idx2);
cleanedLC2=deleteoutliers(L2,0.5);
cleanedSC2=deleteoutliers(S2,0.5);
W=getWeights(cleanedLC1,cleanedLC2,cleanedSC1,cleanedSC2);
[ Lout,Sout ]=getCombinedColorComponent(W,L1,L2,S1,S2);
[accuracy,InSect] = GetAccuracyHistFifNorm(Lout,Sout);
WriteFile( InSect);
WriteFileWeights(W);
clf(gcf);
h1=histfit(Lout);
 hold on
h2=histfit(Sout);
saveas(gcf,'Stats\Stat2.png');