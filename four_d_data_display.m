clear;
clc;
close all;
load('a_r_L_Single_31_31.mat')
[X, Y, Z] = meshgrid(a,r,all_L(41:84));
% scatter3(a,r,all_L(41:84))
scatter3( X(:), Y(:), Z(:) );
m=10;
n=10;
o=44;
S = FWHM4(:,:,41:84); 
S(S==0)=nan;
S=3*10^(8).*S/(1.29668*0.000001)^2;%bandwidth
figure(1)
scatter3( X(:), Y(:), Z(:), [], S(:), 'filled' );
colormap(jet);
c = colorbar;
c.Label.String = 'Elevation (ft in 1000s)';

figure(2)
T =peak4(:,:,41:84); 
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
tt=T(:,:,1)
tt=squeeze(tt);
ss=S(:,:,1)
ss=squeeze(ss);
% uu=U(:,1,:)
% uu=squeeze(uu);

figure(4)
colormap(jet);
surface(r,a,tt)
% view(60,20)
% figure(5)
% colormap(jet);
% surface(all_L(41:84),a,ss)
% view(60,20)
% figure(6)
% colormap(jet);
% surface(all_L(41:84),a,uu)
% view(60,20)
aaa=linspace(0.7,1,100);
rrr=linspace(0.7,1,100)';
% [aaaa, LLL] = meshgrid(aaa,all_L(41:84));
%  [aaa, rrr] = meshgrid(aaa, rrr);
ttt=griddata(a,r,tt,aaa,rrr,'cubic');
sss=griddata(a,r,ss,aaa,rrr,'cubic');
% uuu=griddata(a,r,uu,aaa,rrr,'cubic');
% figure(7)
% colormap(jet);
% surface(all_L(41:84),aaa,uuu)
% figure(8)
% colormap(jet);
% surface(all_L(41:84),aaa,sss)
figure(9)
colormap(jet);
surface(aaa,rrr,ttt);
figure(10)
colormap(jet);
% v=[22,24,26,28,30,32,34,36,38]
% surface(aaa,rrr,ttt)
contour(aaa,rrr,ttt,'ShowText','on')

figure(11)
colormap(jet);
% v=[22,24,26,28,30,32,34,36,38]
% surface(aaa,rrr,sss)
contour(aaa,rrr,sss,'ShowText','on')
% 
% 
