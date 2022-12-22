clear;
clc;
close all;
resolution=10000;% data resolution
startdelta=0.00;
enddelta=0.025;
a=0.97;
r=0.9383;
% L=4.274761274761274e-05% L is obtained through the resonace condition of the MRR
% L=1.825128251282513e-05% L is obtained through the resonace condition of the MRR
% L=5.235382353823538e-05;
L=5.043260043260043e-05;
neff_file_name='neff1000.csv';%the name of the effective index file
ng_file_name='ng1000.csv';%the name of the group index file
maxchannel=8;% the number of wavelength channel
load('available_L.mat')

pks_bar=zeros(125,maxchannel);
locs_bar=zeros(125,maxchannel);
widths_bar=zeros(125,maxchannel);
proms_bar=zeros(125,maxchannel);
EX_3=zeros(125,maxchannel);
EX_4=zeros(125,maxchannel);
switch_state_E_out=zeros(125,256,10000,2);
peaki=zeros(2^maxchannel,maxchannel);
FWHMi=zeros(2^maxchannel,maxchannel);
bottomi=zeros(2^maxchannel,maxchannel);
ERER=zeros(2^maxchannel,maxchannel);




for i=41:1:41
    I=i
L=all_L(i);% L is obtained through the resonace condition of the MRR

[ERER,bottomi,peaki,FWHMi,pks_bar(i,:),locs_bar(i,:),widths_bar(i,:),proms_bar(i,:),EX_3(i,:),EX_4(i,:),switch_state_E_out]=all_switch_state_parameters(resolution,a,r,L,neff_file_name,ng_file_name,maxchannel);
end


