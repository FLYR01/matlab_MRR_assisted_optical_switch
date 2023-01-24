clear;
clc;
close all;
x=linspace(0.85,1,1001)';
y=linspace(0.85,1,1001)';
[a,r]=meshgrid(x,y);
Tdrop=(a-r).^2./(1-a.*r).^2;
dBTdrop=10.*log10(Tdrop);
surf(a,r,Tdrop)
 v=[0.01,0.1,0.2,0.4,0.6,0.8];
contour(a,r,Tdrop,v,'ShowText','on')
% contour(a,r,T_drop)

% a0=0.98;
% a1=0.97;
% a2=0.96;
% a3=0.95;
% a4=0.94;
% a5=0.93;
% a6=0.92;
% r=linspace(0.8,0.955,1000);
% T_drop0=(a0-r).^2./(1-a0.*r).^2;
% T_drop1=(a1-r).^2./(1-a1.*r).^2;
% T_drop2=(a2-r).^2./(1-a2.*r).^2;
% T_drop3=(a3-r).^2./(1-a3.*r).^2;
% T_drop4=(a4-r).^2./(1-a4.*r).^2;
% T_drop5=(a5-r).^2./(1-a5.*r).^2;
% T_drop6=(a6-r).^2./(1-a6.*r).^2;
% plot(r,T_drop0,r,T_drop1,r,T_drop2,r,T_drop3,r,T_drop4,r,T_drop5,r,T_drop6);