function [ae,be,ao,bo]=coupler_fitting(gap, ne,no,startpoint,neff)
%the unit of gap is nm

ax1 = axes; 
% 
% gap =gap*1000000000;


set(ax1, 'XLim', [5e-08 5e-07])
set(ax1, 'YLim', [2.52 2.62])
set(ax1,'XGrid', 'on')
set(ax1,'YGrid', 'on')
 %neff=2.540772;%determined by the geometry of waveguide
 figure(1)
plot(gap, ne,'o')
hold on
plot(gap, no,'o')


se = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...
               'Upper',[Inf,max(gap)],...
               'Startpoint',startpoint);
fe = fittype('a*exp(-b*x)+neff','problem','neff','options',se);

[c2,gof2] = fit(gap, ne,fe,'problem',neff)



so = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...
               'Upper',[Inf,max(gap)],...
               'Startpoint',[0.12 0.012]);
fo = fittype('-a*exp(-b*x)+neff','problem','neff','options',so);


[c3,gof3] = fit(gap, no,fo,'problem',neff)
plot(c2,'m')
plot(c3,'g')
ae=c2.a;
be=c2.b;
ao=c3.a;
bo=c3.b;