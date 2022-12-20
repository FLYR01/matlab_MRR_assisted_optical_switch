%find the the zero ponit of y=f(x), i.e the position of the different sign

function [izero,all_x0,min_x0]=find_0_point(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% parameter annotation %%%%%%%%%%%%%%%%%%%%%%%
% input parameters
% NOTE: x and y are both column vector

% output parameters
% izero: the location of 0 point in array
% all_x0: all the 0 points
% min_x0: the minimum 0 point

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
