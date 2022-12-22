%please run all_state_calculation.m before running this script
a=linspace(1,256,256)';

figure(1)

% plotmatrix(FWHMi)
%plot(a,FWHMi(:,1))
% imagesc(FWHMi);
% h = bar3(FWHMi)
figure(2)
for i=1:1:8
plot(a,peaki(:,i))
hold on;
end
hold off
% imagesc(peaki);
% pcolor(peaki);shading interp;colorbar;colormap(hot);
figure(3)
plot(a,bottomi(:,1))
figure(4)
plot(a,10*log10(ERER(:,1)))

