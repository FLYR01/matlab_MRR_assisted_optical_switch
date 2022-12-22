function [ ERER,bottomi,peaki,FWHMi,pks_bar,locs_bar,widths_bar,proms_bar,EX_3,EX_4,switch_state_E_out]=all_switch_state_parameters(resolution,a,r,L,neff_file_name,ng_file_name,maxchannel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% parameter examples %%%%%%%%%%%%%%%%%%%%%%%%%
% resolution=10000;% dispersion data resolution
% a=0.97;% transmission coefficient
% r=0.9383;% self-coupling coefficient
% L=4.274761274761274e-05% the total length of MRR,L must meet the resonace condition of MRR
% neff_file_name='neff1000.csv';%the name of the effective index file
% ng_file_name='ng1000.csv';%the name of the group index file
% maxchannel=8;% the number of wavelength channel

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% initialization of intermediate variables %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delta_shift=zeros(maxchannel,1);
lambda0=zeros(maxchannel,1);
delta_lambda_b0_min=zeros(maxchannel,1);
delta_lambda_r0_min=zeros(maxchannel,1);
FWHM=zeros(maxchannel,1);
newFWHM=zeros(maxchannel,1);
M=zeros(maxchannel,1);
FSR=zeros(maxchannel,1);
neff0=ones(maxchannel,1);
pneff=ones(maxchannel,2);
ng0=ones(maxchannel,1);
neff=zeros(resolution,maxchannel);
ng=zeros(resolution,maxchannel);
Bar_up_armT=zeros(maxchannel,resolution)';
Bar_bottom_armT=zeros(maxchannel,resolution)';
Cross_up_armT=zeros(maxchannel,resolution)';
Cross_bottom_armT=zeros(maxchannel,resolution)';
Bar_up_armangleT=zeros(maxchannel,resolution)';
Bar_bottom_armangleT=zeros(maxchannel,resolution)';
Cross_up_armangleT=zeros(maxchannel,resolution)';
Cross_bottom_armangleT=zeros(maxchannel,resolution)';
Ith=zeros(maxchannel,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% import the effective index file and group index file %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Ng,Neff]=import_ng_neff(ng_file_name,neff_file_name);


%%% interpolation for the imported Neff and Ng under the data resolution %%
lambda=linspace(Neff.lambda(470),Neff.lambda(590),resolution)';
neff(:,1)=interp1(Neff.lambda,Neff.neff,lambda,'linear');%interpolation for the import Neff
ng(:,1)=interp1(Ng.lambda,Ng.ng,lambda,'linear');%interpolation for the import Neff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Calculate the first wavelength channel %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=1;
% % % % % % % % % % % % calculation of neff and ng % % % %  % % % % % % % %

%find the minimum resonace wavelength and the coresponding ng and neff 
%within the target wavelength range for a given L
[ng0(i),neff0(i),lambda0(i)]=find_resonace_minimum_wavelength(L,lambda,neff(:,i),ng(:,i));

%find the location of lambda0(i) in the dispersion data
[izero_lambda0i,all_lambda0i,lambda0(i)]=find_0_point(lambda,lambda0(i)-lambda);
[izero_neff0i,all_neff0i,neff0i]=find_0_point(lambda,neff(:,i)-neff0(i));
Ith(i)=izero_lambda0i %the location of lambda0(i) in the dispersion data

%fit the dispersion of effective index to calculate the group index
pneff(i,:) = polyfit(lambda,neff(:,i),1);
ng(:,i)=neff(:,i)-lambda.*pneff(i,1);
ng0(i)=ng(izero_neff0i(1),i);

% % % % % % % % % % % % neff tuning to get pi % % % %  % % % % % % % % % %
% % % % % % phase difference between up arm and bottom arm  % % % % % % % %
resolution_neff_tuning_phase=1000;%
neff_tuning_start_phase=0;
neff_tuning_end_phase=0.004;
delta=linspace(neff_tuning_start_phase,neff_tuning_end_phase,resolution_neff_tuning_phase)';
size_delta=size(delta);
y_phase=zeros(size_delta(1,1),1);

for j=1:1:size_delta(1,1)
neffr=neff(:,i)+delta(j);
neffb=neff(:,i)-delta(j);
[Tup]=single_mrr_accurate(a,r,L,lambda,neffr);
[Tbottom]=single_mrr_accurate(a,r,L,lambda,neffb);

y_phase(j)=Tup.angle(izero_lambda0i(1))-Tbottom.angle(izero_lambda0i(1))-pi;

end

figure(1)
subplot(2,1,1)
plot(delta,y_phase)
[izero_delta,all_delta,delta_shift(i)]=find_0_point(delta,y_phase);
neffr=neff(:,i)+delta_shift(i);
neffb=neff(:,i)-delta_shift(i);
[Tup]=single_mrr_accurate(a,r,L,lambda,neffr);
[Tbottom]=single_mrr_accurate(a,r,L,lambda,neffb);
subplot(2,1,2)
plot(lambda,(Tup.angle-Tbottom.angle)/pi);

[delta_lambda_b0_min(i),delta_lambda_r0_min(i),FWHM(i),newFWHM(i),M(i),FSR(i)]=MMR_pair_parameters_calculation(a,r,L,neff,i,delta_shift(i),ng0(i),lambda,lambda0(i));

% % % % % % % % % % % % the target wave band % % % %  % % % % % % % % % % %
%lambda0(1) was given in available_L.m to calculate the appropriate L

lambda0=[lambda0(1);1.29780e-6;1.29893e-6;1.30005e-6;1.30118e-6;1.30231e-6;1.30345e-6;1.30458e-6];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  Calculate the rest wavelength channels %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=2:1:maxchannel

% % % % % the location of lambdai in the dispersion data % % % %  % % % % %

[izero_lambda0i,all_lambda0i,lambda0(i)]=find_0_point(lambda,lambda0(i)-lambda);
Ith(i)=izero_lambda0i
% neff0(i)=neff(izero_lambda0i);
% ng0(i)=ng(izero_lambda0i);
% 
%%%Calculate dispersioin curve of the i-th channel


% % % % % neff tuning to shift to the next wavelength channel  % % % % % %

resolution_neff_tuning_lambdai=10000;%
neff_tuning_start_lambdai=0;
neff_tuning_end_lambdai=0.008;

delta_neff0=linspace(neff_tuning_start_lambdai,neff_tuning_end_lambdai,resolution_neff_tuning_lambdai)';
size_delta_neff0=size(delta_neff0);
y=zeros(size_delta_neff0(1,1),1);

for j=1:1:resolution_neff_tuning_lambdai
neff(:,i)=neff(:,i-1)+delta_neff0(j);

y7=sin(0.5.*(L.*neff(:,i).*(2.*pi)./lambda));
[izero,all,lambda0_d]=find_0_point(lambda,y7);
all_size=size(all);

% find the desired L,which is larger than lambda0(i-1) but the minimum 
% among all the zero point of y7
for k=2:1:all_size(2)
    if (all(k)>lambda0(i-1))
        ;
        if(abs(all(k)-lambda0(i-1))<abs(all(k-1)-lambda0(i-1)))
        lambda0_d=all(k);
        end
    end
end

y(j)=lambda0_d-lambda0(i);

end

figure(1+i);
subplot(3,1,1)
plot(delta_neff0,y);
[izero_delta_neff0i,all_delta_neff0i,delta_neff0i]=find_0_point(delta_neff0,y);
neff0(i)=neff0(i-1)+delta_neff0i;
neff(:,i)=neff(:,i-1)+delta_neff0i;
[izero_neff0i,all_neff0i,neff0i]=find_0_point(lambda,neff(:,i)-neff0(i));

% % % % % % % % % % % % neff tuning to get pi % % % % % %  % % % % % % % %
% % % % % % phase difference between up arm and bottom arm  % % % % % % % %

%fit the dispersion of effective index to calculate the group index
pneff(i,:) = polyfit(lambda,neff(:,i),1);
ng(:,i)=neff(:,i)-lambda.*pneff(i,1);
ng0(i)=ng(izero_neff0i(1),i);
ng(:,i)=neff(:,i)-lambda.*pneff(i,1);

resolution_neff_tuning_phase=1000;%
neff_tuning_start_phase=0;
neff_tuning_end_phase=0.004;
delta=linspace(neff_tuning_start_phase,neff_tuning_end_phase,resolution_neff_tuning_phase)';
size_delta=size(delta);
y_phase=zeros(size_delta(1,1),1);

for j=1:1:size_delta(1,1)
neffr=neff(:,i)+delta(j);
neffb=neff(:,i)-delta(j);
[Tup]=single_mrr_accurate(a,r,L,lambda,neffr);
[Tbottom]=single_mrr_accurate(a,r,L,lambda,neffb);

y_phase(j)=Tup.angle(izero_lambda0i(1))-Tbottom.angle(izero_lambda0i(1))-pi;

end

subplot(3,1,2)
plot(delta,y_phase)
[izero_delta,all_delta,delta_shift(i)]=find_0_point(delta,y_phase);
neffr=neff(:,i)+delta_shift(i);
neffb=neff(:,i)-delta_shift(i);
[Tup]=single_mrr_accurate(a,r,L,lambda,neffr);
[Tbottom]=single_mrr_accurate(a,r,L,lambda,neffb);
subplot(3,1,3)
plot(lambda,(Tup.angle-Tbottom.angle)/pi);

[delta_lambda_b0_min(i),delta_lambda_r0_min(i),FWHM(i),newFWHM(i),M(i),FSR(i)]=MMR_pair_parameters_calculation(a,r,L,neff,i,delta_shift(i),ng0(i),lambda,lambda0(i));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Calculate the phase(field) and amplitude(power)  %%%%%%%%%%%%
%%%%%%%%%%%%% for every channel under Bar and Cross state %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:1:maxchannel
   
    
    [T_cross_uparm]=single_mrr_accurate (a,r,L,lambda,neff(:,i));
    [T_cross_bottomarm]=single_mrr_accurate (a,r,L,lambda,neff(:,i));
    
    [T_bar_uparm]=single_mrr_accurate (a,r,L,lambda,neff(:,i)+delta_shift(i));
    [T_bar_bottomarm]=single_mrr_accurate (a,r,L,lambda,neff(:,i)-delta_shift(i));
    
    Bar_up_armT(:,i)=T_bar_uparm.amplitude;
    Bar_up_armangleT(:,i)=T_bar_uparm.angle;
    Bar_bottom_armT(:,i)=T_bar_bottomarm.amplitude;
    Bar_bottom_armangleT(:,i)=T_bar_bottomarm.angle;
    
    Cross_up_armT(:,i)=T_cross_uparm.amplitude;
    Cross_up_armangleT(:,i)=T_cross_uparm.angle;
    Cross_bottom_armT(:,i)=T_cross_bottomarm.amplitude;
    Cross_bottom_armangleT(:,i)=T_cross_bottomarm.angle;
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Transfer matrix nethod %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%all the switching state
swich=dec2bin(linspace(0,2^maxchannel-1,2^maxchannel));

% % % % % % % % % % initialization of intermediate variables % % %  % % % % 

arm1=zeros(1,resolution)';
arm2=zeros(1,resolution)';
on=1;
off=0;
Ein1=on.*ones(1,resolution)';
Ein2=off.*ones(1,resolution)';
E_in=[Ein1,Ein2];
E_out=0.*[Ein1,Ein2];
MZI_matrix=zeros(2,2,resolution);% to contain every chnannel wavelength's matrix
MMI_matrix=[sqrt(2)/2,1i*sqrt(2)/2;1i*sqrt(2)/2,sqrt(2)/2;];
switch_state_E_out=zeros(2^maxchannel,resolution,2);


% 
  for k=1:1:2^maxchannel %calculate for very switching state
      k
   for m=1:1:resolution % matrix initialization 
   MZI_matrix(:,:,m)=[1,0;0,1];
   end
   
for i=1:1:resolution  %calculate for very lambda
     
     
   for j=1:1:maxchannel %calculate for very channel
       
    if (swich(k,j)=='1')
     arm1(i)=sqrt(Bar_up_armT(i,j)).*exp(1i.*(Bar_up_armangleT(i,j)));
     arm2(i)=sqrt(Bar_bottom_armT(i,j)).*exp(1i.*Bar_bottom_armangleT(i,j));
     MZI_matrix(:,:,i)=MZI_matrix(:,:,i)*[arm1(i),0;0,arm2(i)];
    end
    if (swich(k,j)=='0')
     arm1(i)=sqrt(Cross_up_armT(i,j)).*exp(1i.*(Cross_up_armangleT(i,j)));
     arm2(i)=sqrt(Cross_bottom_armT(i,j)).*exp(1i.*Cross_bottom_armangleT(i,j));
     MZI_matrix(:,:,i)=MZI_matrix(:,:,i)*[arm1(i),0;0,arm2(i)];
    end
   end
 E_out(i,:)=MMI_matrix*MZI_matrix(:,:,i)*[1,0;0,1]*MMI_matrix*E_in(i,:)';

end
 switch_state_E_out(k,:,:)= E_out(:,:);
 
figure(12345678)
% plot(lambda,10*log10(abs(switch_state_E_out(k,:,2).^2)))
[ax, h1, h2]=plotyy(lambda,10*log10(abs(switch_state_E_out(k,:,1).^2)),lambda,10*log10(abs(switch_state_E_out(k,:,2).^2)));
title('All in bar state','FontSize',15);
xlabel('Wavelength [m]','FontSize',15);
ylabel(ax(1),'Transmission [dB]','FontSize',15) % left y-axis 
ylabel(ax(2),'Transmission [dB]','FontSize',15) % 
legend([h1,h2],'P1-P3','P1-P4');
set(h1,'color','k','linewidth',1);%

set(h2,'color','r','linewidth',1);%

set(ax(1),'ycolor','k','fontsize',14)%

set(ax(2),'ycolor','r','fontsize',14)


  end


%%%%%%%%%%% Calculate the ER for every wavelength channel %%%%%%%%%%%%%%%%%   

sum_3_on=zeros(8,resolution);
sum_3_off=zeros(8,resolution);
sum_4_on=zeros(8,resolution);
sum_4_off=zeros(8,resolution);
peaki=zeros(2^maxchannel,maxchannel);
FWHMi=zeros(2^maxchannel,maxchannel);
bottomi=zeros(2^maxchannel,maxchannel);
ERER=zeros(2^maxchannel,maxchannel);

for j=1:1:maxchannel
    for k=1:1:2^maxchannel
        if (swich(k,j)=='1')
            sum_3_on(j,:)=abs(switch_state_E_out(k,:,1).^2)+sum_3_on(j,:);
             [peaki(k,j),FWHMi(k,j)]=find_peak_parameters(lambda,abs(switch_state_E_out(k,:,1)'.^2),lambda(Ith(j)));
        end
  
        if (swich(k,j)=='0')
         
           sum_3_off(j,:)=abs(switch_state_E_out(k,:,1).^2)+sum_3_off(j,:);
           bottomi(k,j)=abs(switch_state_E_out(k,Ith(j),1)'.^2);
           
        end
    end

end


for j=1:1:maxchannel
    for k=1:1:2^maxchannel
       if (swich(k,j)=='1')
           
           k_binary=dec2bin(k-1,maxchannel)
           k_binary(j)='0';
           bin2dec(k_binary)
           ERER(k,j)=peaki(k,j)/bottomi( bin2dec(k_binary)+1,j);
           
        end
    end

end



for j=1:1:maxchannel
    for k=1:1:2^maxchannel
        if (swich(k,j)=='1')
            sum_4_on(j,:)=abs(switch_state_E_out(k,:,2).^2)+sum_4_on(j,:);
        end
  
        if (swich(k,j)=='0')
           sum_4_off(j,:)=abs(switch_state_E_out(k,:,2).^2)+sum_4_off(j,:);
        end
    end

end


plotyy(lambda,10*log10(sum_3_on(1,:)/2^(maxchannel-1)),lambda,10*log10(sum_3_off(1,:)/2^(maxchannel-1)))
EX_3=zeros(8,1);
EX_4=zeros(8,1);

% Calculate the average ER of port 3 for every wavelength channel
% switching state average
for i=1:1:8
EX_3(i)=10*log10(sum_3_on(i,Ith(i))/2^(maxchannel-1))-10*log10(sum_3_off(i,Ith(i))/2^(maxchannel-1));
end


% Calculate the average ER of port 4 for every wavelength channel
% switching state average
for i=1:1:8
EX_4(i)=10*log10(sum_4_off(i,Ith(i))/2^(maxchannel-1))-10*log10(sum_4_on(i,Ith(i))/2^(maxchannel-1));
end

figure(12034)
 
pks_bar=zeros(maxchannel,1);
locs_bar=zeros(maxchannel,1);
widths_bar=zeros(maxchannel,1);
proms_bar=zeros(maxchannel,1);
lambda=lambda(1020:8300,1);
% Calculate the average FWHM, Peak, Peak_location for every wavelength channel
% switching state average
for i=1:1:maxchannel
    i
    figure(12034+i)
findpeaks(sum_3_on(i,1020:8300)/2^(maxchannel-1),lambda,'MinPeakDistance',1.1e-9,'MinPeakHeight',0.2);
[pks_bar(i),locs_bar(i),widths_bar(i),proms_bar(i)] = findpeaks(sum_3_on(i,1020:8300)/2^(maxchannel-1),lambda,'MinPeakDistance',1.1e-9,'MinPeakHeight',0.2);
end



