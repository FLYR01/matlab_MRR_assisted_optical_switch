function [izero,all_x0,min_x0]=find_0_point(x,y)
intervals=(y<=0)-(y>0);
izerosup=find(diff(intervals)<0);
intervals=(y>0)-(y<=0);
izerosdown=find(diff(intervals)<0);
izero=[izerosup;izerosdown];
izero=sort(izero);
izerosize=size(izero);
all_x0=zeros(izerosize(1,1),1);

for i=1:1:izerosize(1,1)
all_x0(i)=[x(izero(i))];
end
all_x0=all_x0';
min_x0=all_x0(1);
