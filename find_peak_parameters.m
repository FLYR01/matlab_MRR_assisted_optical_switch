% find the peak value y_0 and FWHM for a given peak location x_0 in 
function [y_0,FWHM]=find_peak_parameters(x,y,x_0)
%%%%%%%%%%%%%%%%%%%%%%%%parameter examples%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x=linspace(0,10*pi,1000000)';Note:This must be a column vector
% y=sin(x);
% x_0=pi/2;
y_temp1=x-x_0;
[izero_0,~,~]=find_0_point(x,y_temp1);
y_0=y(izero_0(1));
y_temp2=y-y_0/2;
if (y_0/2>min(y))
[izero_half,~,~]=find_0_point(x,y_temp2);
Temp=[izero_0;izero_half];
Temp=sort(Temp);
i_0=find(Temp==izero_0); 
FWHM=x(Temp(i_0+1))-x(Temp(i_0-1));

end
if (y_0/2<=min(y))
   FWHM=1000;
end