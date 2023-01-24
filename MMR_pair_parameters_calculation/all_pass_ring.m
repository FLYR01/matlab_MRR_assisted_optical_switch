clear;
clc;
close all;
ng_file_name='ng1000.csv';
neff_file_name='neff1000.csv';
resolution=100000;
a=0.97;
r=0.94;
load('available_L.mat');
L=all_L(66);

[Ng,Neff]=import_ng_neff(ng_file_name,neff_file_name);


%%% interpolation for the imported Neff and Ng under the data resolution %%
lambda=linspace(Neff.lambda(300),Neff.lambda(590),resolution)';
neff=interp1(Neff.lambda,Neff.neff,lambda,'linear');%interpolation for the import Neff
ng=interp1(Ng.lambda,Ng.ng,lambda,'linear');%interpolation for the import Neff

[T]=single_mrr_accurate (a,r,L,lambda,neff);
plotyy(T.lambda,T.angle,T.lambda,T.amplitude)