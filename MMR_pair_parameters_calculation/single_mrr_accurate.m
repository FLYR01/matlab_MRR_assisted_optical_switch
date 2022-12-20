%this function take the dispersion of neff into consideration to calculate 
%the complex transmission coefficient
function [T]=single_mrr_accurate (a,r,L,lambda,neff)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% parameter annotation %%%%%%%%%%%%%%%%%%%%%%%
% input parameters
% a: single-pass amplitude transmission coefficient
% r: self-coupling coefficient
% L: the total length of MRR,L must meet the resonace condition of MRR
% lambda,neff: the dispersion curve

% output parameters
% T: complex transmission coefficient of all-pass ring resonator,power
% amplitude and field phase



beta=neff.*(2*pi./lambda);
phi=L.*beta;
T.amplitude=(a^2-2*r*a.*cos(phi)+r^2)./(1-2*r*a.*cos(phi)+(r*a)^2);
% Please note that above is the power amplitude not the field amplitude
T.angle=pi+phi+atan(r.*sin(phi)./(a-r.*cos(phi)))+atan(r*a.*sin(phi)./(1-r*a.*cos(phi)));
T.lambda=lambda;
