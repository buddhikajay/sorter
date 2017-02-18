function [accuracy,InSect] = GetAccuracyHistFifNorm(Class1,Class2)
clf(gcf);
h1=histfit(Class1);
 hold on
h2=histfit(Class2);
delete(h1(1));
delete(h2(1));
%str = int2str(i);
%str2 = int2str(j);
%s = strcat(str,'_',str2,Nstr,'.png');
saveas(gcf,'Stats\Stat.png');
%set(gcf, 'Visible', 'off');
tx1=get(h1(2),'XData');
tx2=get(h2(2),'XData');
ty1=get(h1(2),'YData');
ty2=get(h2(2),'YData');
xx=linspace(min([tx1,tx2]),max([tx1,tx2]),500);
p1 = polyfit([tx1],[ty1],10);
p2 = polyfit([tx2],[ty2],10);
y1 = polyval(p1,xx);
y2 = polyval(p2,xx);
y=max(y1,y2);
hold on
plot(xx,y,'b');

C1 = trapz(tx1,ty1);
C2 = trapz(tx2,ty2);
C1C2= trapz(xx,y);
OverlappingArea=C1+C2-C1C2;
accuracy=(1-(OverlappingArea/C1C2))*100;
InSect=InterX([tx1;ty1],[tx2;ty2]);
end

