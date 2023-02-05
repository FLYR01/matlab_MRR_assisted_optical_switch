load D:/20230203_a_r_gap_L_mapping/test_ha.mat;
ax1 = axes; 
plot(lum.x0, lum.y0,lum.x1, lum.y1)
set(ax1, 'XLim', [5e-08 5e-07])
set(ax1, 'YLim', [2.52 2.62])
set(ax1,'XGrid', 'on')
set(ax1,'YGrid', 'on')
