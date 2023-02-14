load in_model_odd_even_neff(130458).mat;
ax1 = axes; 
plot(lum.x0, lum.y0,lum.x1, lum.y1)
set(ax1, 'XLim', [4e-08 5e-07])
set(ax1, 'YLim', [2.5 2.62])
set(ax1,'XGrid', 'on')
set(ax1,'YGrid', 'on')
