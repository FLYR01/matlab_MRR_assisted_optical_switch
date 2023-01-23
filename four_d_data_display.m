%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note: there are some parameter fault
clear;
clc;
close all;
load('llz3.mat')
[X, Y, Z] = meshgrid(a,r,all_L(41:84));
% scatter3(a,r,all_L(41:84))
scatter3( X(:), Y(:), Z(:) );
m=10;
n=10;
o=44;
S = bottom4(:,:,41:84);%fwhm 
S(S==0)=nan;
S=3*10^(8).*S/(1.29668*0.000001)^2;%bandwidth
figure(1)
scatter3( X(:), Y(:), Z(:), [], S(:), 'filled' );
colormap(jet);
c = colorbar;
c.Label.String = 'Elevation (ft in 1000s)';

figure(2)
T =ERER4(:,:,41:84); %peak4
T(T==0)=nan;
T=10*log10(T);
colormap(jet);
scatter3( X(:), Y(:), Z(:), [], T(:), 'filled' );

c = colorbar;
c.Label.String = 'Elevation (ft in 1000s)';
c.LimitsMode='manual';
c.Limits=[-10,0];

U=ERER4(:,:,41:84); 
figure(3)
U(U==0)=nan;
U=10*log10(U);
scatter3( X(:), Y(:), Z(:), [], U(:), 'filled' );
colormap(jet);
c = colorbar;
c.Label.String = 'Elevation (ft in 1000s)';

tt1=T(:,:,1);
tt1=squeeze(tt1);
ss1=S(:,:,1);
ss1=squeeze(ss1);
% uu=U(:,1,:)
% uu=squeeze(uu);

figure(4)
colormap(jet);
surface(r,a,tt1)
% view(60,20)
% figure(5)
% colormap(jet);
% surface(all_L(41:84),a,ss)
% view(60,20)
% figure(6)
% colormap(jet);
% surface(all_L(41:84),a,uu)
% view(60,20)
aaa=linspace(0.8,1,1000);
rrr=linspace(0.8,1,1000)';
% [aaaa, LLL] = meshgrid(aaa,all_L(41:84));
%  [aaa, rrr] = meshgrid(aaa, rrr);
ttt1=griddata(a,r,tt1,aaa,rrr,'cubic');
sss1=griddata(a,r,ss1,aaa,rrr,'cubic');
% uuu=griddata(a,r,uu,aaa,rrr,'cubic');
% figure(7)
% colormap(jet);
% surface(all_L(41:84),aaa,uuu)
% figure(8)
% colormap(jet);
% surface(all_L(41:84),aaa,sss)
figure(9)
colormap(jet);
surface(aaa,rrr,ttt1);

figure(10)
colormap(jet);
%v=[0,-0.1,-0.5,-1,-1.5,-2,-3,-4,-5]
% surface(aaa,rrr,ttt)
contour(aaa,rrr,ttt1,'ShowText','on')

figure(11)
colormap(jet);
% v=[22,24,26,28,30,32,34,36,38]
% surface(aaa,rrr,sss)
contour(aaa,rrr,sss1,'ShowText','on')
% 
% 



tt2=T(:,:,40)
tt2=squeeze(tt2);
ss2=S(:,:,40)
ss2=squeeze(ss2);
% uu=U(:,1,:)
% uu=squeeze(uu);

% view(60,20)
% figure(5)
% colormap(jet);
% surface(all_L(41:84),a,ss)
% view(60,20)
% figure(6)
% colormap(jet);
% surface(all_L(41:84),a,uu)
% view(60,20)
aaa=linspace(0.8,1,1000);
rrr=linspace(0.8,1,1000)';
% [aaaa, LLL] = meshgrid(aaa,all_L(41:84));
%  [aaa, rrr] = meshgrid(aaa, rrr);
ttt2=griddata(a,r,tt2,aaa,rrr,'cubic');
sss2=griddata(a,r,ss2,aaa,rrr,'cubic');


figure(12)
colormap(jet);
v=[0,-0.1,-0.5,-1,-1.5,-2,-3,-4,-5]
% surface(aaa,rrr,ttt)
contour(aaa,rrr,ttt2,v,'ShowText','on')

figure(13)
colormap(jet);
% v=[22,24,26,28,30,32,34,36,38]
% surface(aaa,rrr,sss)
contour(aaa,rrr,sss2,'ShowText','on')

