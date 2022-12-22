%please run all_state_calculation.m before running this script
peak0=find(peaki==0);
peaki(peak0)=[];
peaki=reshape(peaki,128,8);

FWHM0=find(FWHMi==0);
FWHMi(FWHM0)=[];
FWHMi=reshape(FWHMi,128,8);

ERER0=find(ERER==0);
ERER(ERER0)=[];
ERER=reshape(ERER,128,8);



a=linspace(1,256,256)';
b=linspace(1,128,128)';

figure(1)

for i=1:1:8
plot(b,FWHMi(:,i))
hold on;
end
hold off

figure(2)

for i=1:1:8
plot(b,10*log10(peaki(:,i)))
hold on;
end
hold off

% imagesc(peaki);
% pcolor(peaki);shading interp;colorbar;colormap(hot);
figure(3)
plot(a,bottomi(:,1))

figure(4)

for i=1:1:8
plot(b,10*log10(ERER(:,i)))
hold on;
end
hold off

