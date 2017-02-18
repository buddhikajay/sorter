function [ total,sz] = GetOverlappingArea( class1,class2 )
total=0;
k=1;
i=1;
sz=length(class1)+length(class2);
class1=roundn(class1,0);
class2=roundn(class2,0);
Cmin = min(min(class1), min(class2));
tblclass1 = tabulate(class1);
tblclass2 = tabulate(class2);
if Cmin == min(class1)
     i = 1;
    total = 0;
    while ((size((tblclass1(:,1)),1) - i >= 0)&&(min(class2) >= tblclass1(i, 1)))
        i = i + 1;
    end;
    if (size(unique(tblclass1(:,1)),1)==i)
        return ;
    end;
        
    k=1;
     while size(tblclass1,1) - i >= 0
         if ((i<= size(tblclass1,1))&&(k<= size(tblclass2,1)))
            if tblclass1(i, 1)==tblclass2(k, 1)
                total = total + min(tblclass1(i, 2), tblclass2(k, 2));
                i = i + 1;
                k = k + 1;
            elseif  tblclass1(i, 1)> tblclass2(k, 1)
                total = total +tblclass2(k, 2);   
                k = k + 1;
            else 
                total = total +tblclass1(i, 2);   
                i = i + 1;
            end;
        else
              return;
          end;
    end;
end;
if Cmin == min(class2)
    i = 1;
    total = 0;
    while ((size(tblclass2,1) - i > 0)&&(min(class1) >= tblclass2(i, 1)))
        i = i + 1;
    end;
     if (size(unique(tblclass2(:,1)),1)==i)
        return ;
    end;
    k=1;
    while size(tblclass2,2) - i >= 0
          if ((i<= size(tblclass2,1))&&(k<= size(tblclass1,1)))
            if tblclass2(i, 1)==tblclass1(k, 1)
                total = total + min(tblclass2(i, 2), tblclass1(k, 2));
                i = i + 1;
                k = k + 1;
            elseif  tblclass2(i, 1)> tblclass1(k, 1)
                total = total +tblclass1(k, 2);   
                k = k + 1;
            else 
                total = total +tblclass2(i, 2);   
                i = i + 1;
            end;
          else
              return;
          end;
    end;
end;

end

