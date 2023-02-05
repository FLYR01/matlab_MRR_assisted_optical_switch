clc;
clear;
close all;
a=2096.3;
b=2.9123;
c=2;

R_um=linspace(1,10,50);
alpha_db_cm=a.*(R_um).^(-b)+c;
figure(1)
plot(R_um,alpha_db_cm);
figure(2)
a_onetrip=10.^(-(alpha_db_cm.*2.*pi.*R_um.*0.0001/20));
plot(R_um,a_onetrip);

save('a.mat','')


