clear;
clc;
close all;
z = 0:0.01:5;
% 
% I = zeros(5,501);
% for nu = 0:4
%     I(nu+1,:) = besseli(nu,z);
% end
% 
% plot(z,I)
% axis([0 5 0 8])
% grid on
% legend('I_0','I_1','I_2','I_3','I_4','Location','NorthWest')
% title('Modified Bessel Functions of the First Kind for $\nu \in [0,4]$','interpreter','latex')
% xlabel('z','interpreter','latex')
% ylabel('$I_\nu(z)$','interpreter','latex')
B=pi.*z.*exp(-z).*(besseli(1,z)+StruveL1(z))+struveL(-1, z)