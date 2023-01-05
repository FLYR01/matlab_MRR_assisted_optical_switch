clear;
clc;
close all;
resolution=10000;% data resolution
startdelta=0.00;
enddelta=0.025;
aj=10;
rk=10;
a=0.97
r=0.94
% L=4.274761274761274e-05% L is obtained through the resonace condition of the MRR
% L=1.825128251282513e-05% L is obtained through the resonace condition of the MRR
% L=5.235382353823538e-05;
L=5.043260043260043e-05;
neff_file_name='neff1000.csv';%the name of the effective index file
ng_file_name='ng1000.csv';%the name of the group index file
maxchannel=1;% the number of wavelength channel
load('available_L.mat')

pks_bar=zeros(125,maxchannel);
locs_bar=zeros(125,maxchannel);
widths_bar=zeros(125,maxchannel);
proms_bar=zeros(125,maxchannel);
EX_3=zeros(125,maxchannel);
EX_4=zeros(125,maxchannel);
switch_state_E_out=zeros(125,resolution,2);
ERER4=zeros(aj,rk,125);
bottom4=zeros(aj,rk,125);
peak4=zeros(aj,rk,125);
FWHM4=zeros(aj,rk,125);

for j=1:1:1
    for k=1:1:1
        if (a(j)-r(k)>0.0001)
            for i=66:1:66
               I=i
               L=all_L(i);% L is obtained through the resonace condition of the MRR
               [ERER4(j,k,i),peak4(j,k,i),bottom4(j,k,i),FWHM4(j,k,i),switch_state_E_out(i,:,:)]=all_switch_state_parameters(resolution,a(j),r(k),L,neff_file_name,ng_file_name,maxchannel);
            end

        end
    end
end




