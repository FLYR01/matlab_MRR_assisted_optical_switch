
close all;
clear;
clc;

a=2096.3;
b=2.9123;
c=2;

R_um=linspace(1,10,50);

alpha_db_cm=a.*(R_um).^(-b)+c;
a_onetrip=10.^(-(alpha_db_cm.*2.*pi.*R_um.*0.0001/20));
figure(2)
plot(R_um,alpha_db_cm);
figure(5)
plot(R_um,a_onetrip);


% load D:/20230203_a_r_gap_L_mapping/test_ha.mat;
load D:/20230203_a_r_gap_L_mapping/test_ha.mat;


gap = lum.x0';
gap =gap*1000000000;
ne = lum.y0';
no = lum.y1';
startpoint=[0.12 0.012];
[ae,be,ao,bo]=coupler_fitting(gap, ne,no,startpoint);
R=3000;
d=50;
width=400;
xe=be*(R+width/2)
xo=bo*(R+width/2)
kappa=sin(pi/1304.58*((ae/be)*exp(-be*d)*B(xe)+(ao/bo)*exp(-bo*d)*B(xo)))

dd=linspace(50,400,1000)';
kk=zeros(1000,1);
for i=1:1:1000

kk(i)=sin(pi/1304.58*((ae/be)*exp(-be*dd(i))*B(xe)+(ao/bo)*exp(-bo*dd(i))*B(xo)));
end
tt=sqrt(1-kk.^2);
figure(4)
plot(dd,kk,dd,tt)



