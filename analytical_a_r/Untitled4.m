clear;
clc;
close all;
load D:/20230203_a_r_gap_L_mapping/test_ha.mat;
ax1 = axes; 
gap = lum.x0';
gap =gap*1000000000;
ne = lum.y0';
no = lum.y1';
startpoint=[0.12 0.012];
plot(gap, ne,lum.x1, lum.y1)
set(ax1, 'XLim', [5e-08 5e-07])
set(ax1, 'YLim', [2.52 2.62])
set(ax1,'XGrid', 'on')
set(ax1,'YGrid', 'on')
 neff=2.550299;
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
