clear;
clc;

load('Sweep_a_r_L.mat')
[X, Y, Z] = meshgrid(a,r,all_L(41:84));
% scatter3(a,r,all_L(41:84))
scatter3( X(:), Y(:), Z(:) )
m=7;
n=7;
o=44;
S = FWHM4(:,:,41:84); 
S(S==0)=nan;
S=3*10^(8).*S/(1.30118*0.000001)^2;%bandwidth
figure(1)
scatter3( X(:), Y(:), Z(:), [], S(:), 'filled' )
colormap(jet)
c = colorbar;
c.Label.String = 'Elevation (ft in 1000s)';

figure(2)
T =peak4(:,:,41:84); 
T(T==0)=nan;
T=10*log10(T);
colormap(jet)
scatter3( X(:), Y(:), Z(:), [], T(:), 'filled' )

c = colorbar;
c.Label.String = 'Elevation (ft in 1000s)';
c.LimitsMode='manual'
c.Limits=[-10,0]

U=ERER4(:,:,41:84); 
figure(3)
U(U==0)=nan;
U=10*log10(U);
scatter3( X(:), Y(:), Z(:), [], U(:), 'filled' )
colormap(jet)
c = colorbar;
c.Label.String = 'Elevation (ft in 1000s)';