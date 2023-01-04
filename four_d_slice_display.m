clear;
clc;
close all;
load('sweep_a_r_L(first_state)_ar(100).mat')
[X, Y, Z] = meshgrid(a,r,all_L(41:84));
% scatter3(a,r,all_L(41:84))
scatter3( X(:), Y(:), Z(:) );
m= 10;
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
tt=T(:,1,:)
tt=squeeze(tt);
ss=S(:,1,:)
ss=squeeze(ss);
uu=U(:,1,:)
uu=squeeze(uu);


figure(4)
colormap(jet);
surface(all_L(41:84),a,tt)
view(60,20)
figure(5)
colormap(jet);
surface(all_L(41:84),a,ss)
view(60,20)
figure(6)
colormap(jet);
surface(all_L(41:84),a,uu)
view(60,20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aaa=linspace(0.90,0.98,44);

[aaaa, LLL] = meshgrid(aaa,all_L(41:84));

ttt=griddata(all_L(41:84),a,tt,all_L(41:84),aaa,'cubic');
sss=griddata(all_L(41:84),a,ss,all_L(41:84),aaa,'cubic');
uuu=griddata(all_L(41:84),a,uu,all_L(41:84),aaa,'cubic');
figure(7)
colormap(jet);
surface(all_L(41:84),aaa,uuu)
figure(8)
colormap(jet);
surface(all_L(41:84),aaa,sss)
figure(9)
colormap(jet);
surface(all_L(41:84),aaa,ttt)
figure(10)
colormap(jet);
v=[16,18,20,22,24,26,28,30,32,34,36,38]
surface(all_L(41:84),aaa,uuu)
contour(all_L(41:84),aaa,uuu,v,'ShowText','on')


figure(11)

% rrr=linspace(0.91,0.97,44);
% 
% [XX,YY,ZZ]=meshgrid(aaa,rrr,all_L(41:84));
% 
% 
% XO = [a;r;all_L(41:84)'];
% 
% XI = [aaa,rrr,all_L(41:84)'];
% YI = griddatan(XO,U,XI);
% 
% scatter3( XX, YY, ZZ, [], YI, 'filled' );
% 
% load mri
% D = double(squeeze(U));
% D(D==0)=nan;
% h = slice(D, [], [], 1:size(D,3));
% set(h, 'EdgeColor','none', 'FaceColor','interp')
% alpha(.2)
