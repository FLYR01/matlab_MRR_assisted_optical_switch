clear;
clc;
close all;

load test_ha.mat;% this file is the neff of even and odd mode
load('available_L.mat')


gap = lum.x0';
gap =gap*1000000000;
ne = lum.y0';
no = lum.y1';
startpoint=[0.12 0.012];
[ae,be,ao,bo]=coupler_fitting(gap,ne,no,startpoint);%ae,ao,be,bo are determind by the geometry of waveguide
width=400;%unit:nm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
resolution=94;
R_vector=all_L(11:104)*1E9/(2*pi);%give the radius of microring resonator, this can be obtained by all_L/2pi
d_vector=linspace(50,250,resolution);% give the distance between the ring and the straight waveguide.
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
a=a_onetrip;
r=r_selfcoupling;


aj=94;
rk=94;

















resolution=10000;% data resolution
startdelta=0.00;
enddelta=0.025;

% L=4.274761274761274e-05% L is obtained through the resonace condition of the MRR
% L=1.825128251282513e-05% L is obtained through the resonace condition of the MRR
% L=5.235382353823538e-05;
% L=5.043260043260043e-05;
neff_file_name='neff1000.csv';%the name of the effective index file
ng_file_name='ng1000.csv';%the name of the group index file
maxchannel=1;% the number of wavelength channel
load('available_L.mat')
% 
% pks_bar=zeros(125,maxchannel);
% locs_bar=zeros(125,maxchannel);
% widths_bar=zeros(125,maxchannel);
% proms_bar=zeros(125,maxchannel);
% EX_3=zeros(125,maxchannel);
% EX_4=zeros(125,maxchannel);
% switch_state_E_out=zeros(125,resolution,2);
% ERER4=zeros(aj,rk,125);
% bottom4=zeros(aj,rk,125);
% peak4=zeros(aj,rk,125);
% FWHM4=zeros(aj,rk,125);
% delta_lambda_b0_min=zeros(aj,rk,125);
% delta_lambda_r0_min=zeros(aj,rk,125);
% FWHM=zeros(aj,rk,125);
% newFWHM=zeros(aj,rk,125);
% 
% for j=1:1:aj
%    
%     for k=1:1:rk
%         
%         if (a(j)-r(k)>0.00001)
%             for i=41:1:84
%                 I=i
%                 j
%                 k
%                 L=all_L(i);% L is obtained through the resonace condition of the MRR
%                 [delta_lambda_b0_min(j,k,i),delta_lambda_r0_min(j,k,i),FWHM(j,k,i),newFWHM(j,k,i),ERER4(j,k,i),peak4(j,k,i),bottom4(j,k,i),FWHM4(j,k,i),switch_state_E_out(i,:,:)]=all_switch_state_parameters(resolution,a(j),r(i-40,k),L,neff_file_name,ng_file_name,maxchannel);
%             end
% 
%         end
%     end
% end





pks_bar=zeros(aj,maxchannel);
locs_bar=zeros(aj,maxchannel);
widths_bar=zeros(aj,maxchannel);
proms_bar=zeros(aj,maxchannel);
EX_3=zeros(aj,maxchannel);
EX_4=zeros(aj,maxchannel);
switch_state_E_out=zeros(aj,resolution,2);
ERER4=zeros(aj,aj);
bottom4=zeros(aj,aj);
bottom_4=zeros(aj,aj);
peak4=zeros(aj,aj);
FWHM4=zeros(aj,aj);
delta_lambda_b0_min=zeros(aj,aj);
delta_lambda_r0_min=zeros(aj,aj);
FWHM=zeros(aj,aj);
newFWHM=zeros(aj,aj);
L=all_L(11:104);

for i=1:1:aj
   
    for k=1:1:rk
        
        if (a(i)-r(i,k)>0.01)
            
                i
                k
                % L is obtained through the resonace condition of the MRR
                [delta_lambda_b0_min(i,k),delta_lambda_r0_min(i,k),FWHM(i,k),newFWHM(i,k),ERER4(i,k),peak4(i,k),bottom4(i,k),FWHM4(i,k),switch_state_E_out(i,:,:),bottom_4(i,k)]=all_switch_state_parameters(resolution,a(i),r(i,k),L(i),neff_file_name,ng_file_name,maxchannel);
        end

    end
end