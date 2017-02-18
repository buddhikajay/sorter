function [ accuracy ]= GetAccuracy2(D1,D2)
Thh=0;
bin1=3.49*std([D1])*power(length(D1),-1/3); %Scott suggested using the Gaussian density as a reference standard
bin2=3.49*std([D2])*power(length(D2),-1/3); %Scott suggested using the Gaussian density as a reference standard
bin=min(bin1,bin2);
Mxx=max(max(D1),max(D2));
Min=min(min(D1),min(D2));
x_values = Min:bin:Mxx;
[h1, z1] = hist(D1, x_values);
[h2, z2] = hist(D2, x_values);
Mx = max(z1(1), z2(1));
j = 1;
Mx = max(z1(1), z2(1));
KKK=zeros(1,Mx,'double');
if z2(1) == Mx
    for i = 1:size(z1, 1)
        if z1(i) >= Mx
			if j<=size(h2,2)
				KKK(i) = min(h1(i), h2(j));
				j = j + 1;
			end;
        end;
    end;
end;

if z1(1) == Mx
    for i = 1:size(z2, 1)
        if z2(i) >= Mx
			if j<=size(h1,2)
				KKK(i) = min(h1(j), h2(i));
				j = j + 1;
			end;
        end; 
    end;
end;
overMax=min([length(D1),length(D2)]);
accuracy = sum(KKK)/overMax;

end

