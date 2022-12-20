%find the minimum resonace wavelength and the coresponding ng and neff 
%within the target wavelength range for a given L
function [ng0,neff0,lambda0]=find_resonace_minimum_wavelength(L,lambda,neff,ng)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% parameter annotation %%%%%%%%%%%%%%%%%%%%%%%
% input parameters
% L:the total length of MRR,L must meet the resonace condition of MRR
% lambda,neff: the effective index dipersion curve
% lambda,ng:the group index dipersion curve

% output parameters
% lambda0: the center wavelength of the target wavelength channel
% ng0: the group index corresponding to lambda0
% neff0: the effective index corresponding to lambda0

y=sin(0.5.*(L.*neff.*(2.*pi)./lambda));%%find the resonance points
[izero,~,lambda0]=find_0_point(lambda,y);
neff0=neff(izero(1));
ng0=ng(izero(1));



