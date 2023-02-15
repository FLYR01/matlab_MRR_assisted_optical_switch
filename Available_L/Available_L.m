clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%% Import ng and neff file %%%%%%%%%%%%%%%%%%%%%%%%%
%ng: group index
%neff: effective index

neff_file_name='in_model_neff_width_380.csv';
ng_file_name='in_model_ng_width_380.csv';
[Ng,Neff]=import_ng_neff(ng_file_name,neff_file_name);

%%%%%%%%%%%%%%%%%%%%%%%%% Interpolation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

resolution_dispersion=1000000;% Resolution of dispersion interpolation
lambda=linspace(Neff.lambda(550),Neff.lambda(end),resolution_dispersion)';
neff(:,1)=interp1(Neff.lambda,Neff.neff,lambda,'linear');%interpolation for the import Neff
ng(:,1)=interp1(Ng.lambda,Ng.ng,lambda,'linear');%interpolation for the import Neff

%%%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

resolution_L=10000;% Resolution of L
L_start=10e-6;L_end=70e-6;% range of L
L=linspace(L_start,L_end,resolution_L)';
lambda0=zeros(1,resolution_L);
lambda_target=1.30458e-6;
%lambda_target=1.29668e-6;

%%%%%%%%%%%%%%%%%%%%%%%%% Calculation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:resolution_L

y=sin(0.5.*(L(i).*neff(:,1).*(2.*pi)./lambda));%%find the resonance wavelength(lambda)
% figure(3)
% plot(lambda,y);
[izero,all_lambda0,lambda0(i)]=find_0_point(lambda,y);
% size(all_lambda0)
% lanmda1(i)=all_lambda0(2);

end

lambda0=lambda0';
figure(1)
plot(L,lambda0);


figure(2)
plot(L,lambda0-lambda_target)

% find the target L corresponding to the target resonance wavelength
y=lambda0-lambda_target;
intervals=(y<=0)-(y>0);
izerosup=find(diff(intervals)<0);
intervals=(y>0)-(y<=0);
izerosdown=find(diff(intervals)<0);
izero=[izerosup];%izerosdown is discarded because they are caused by error in numerical calculation
izero=sort(izero);
izerosize=size(izero);
all_L=zeros(izerosize(1,1),1);

for i=1:1:izerosize(1,1)
all_L(i)=[L(izero(i))];
end

%%%%%%%%%%%%%%%%%%%%%%%%% Data save %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('available_L.mat','all_L');
 


