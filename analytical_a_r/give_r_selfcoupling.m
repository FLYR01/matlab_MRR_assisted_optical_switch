clc;
clear;
close all;
load test_ha.mat;% this file is the neff of even and odd mode

gap = lum.x0';
gap =gap*1000000000;
ne = lum.y0';
no = lum.y1';
startpoint=[0.12 0.012];
[ae,be,ao,bo]=coupler_fitting(gap,ne,no,startpoint);%ae,ao,be,bo are determind by the geometry of waveguide
width=400;%unit:nm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
resolution=101;
R_vector=linspace(1000,10000,resolution);%give the radius of microring resonator, this can be obtained by all_L/2pi
d_vector=linspace(50,500,resolution);% give the distance between the ring and the straight waveguide.
R_um_vector=R_vector/1000;
a_onetrip=zeros(resolution,1);
r_selfcoupling=zeros(resolution,resolution);
% R=5000;%unit:nm
% R_um=R/1000;
% d=100;%unit:nm
for i=1:1:resolution
    for j=1:1:resolution
    
xe=be*(R_vector(i)+width/2);
xo=bo*(R_vector(i)+width/2);
kappa=sin(pi/1304.58*((ae/be)*exp(-be*d_vector(j))*B(xe)+(ao/bo)*exp(-bo*d_vector(j))*B(xo)));
r_selfcoupling(i,j)=sqrt(1-kappa^2);
a_onetrip(i)=give_onetrip_a(R_um_vector(i));
    end
end

for i=1:1:resolution
    for j=1:1:resolution
        if r_selfcoupling(i,j)>a_onetrip(i)
           r_selfcoupling(i,j)=nan;
        end

    end
end

figure(3)
surface(r_selfcoupling)




