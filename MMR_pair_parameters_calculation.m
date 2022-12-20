% find the resonance wavelength shift caused by heating or electrical tunning
% and the corresponding phase change curves
function [delta_lambda_b0_min,delta_lambda_r0_min,FWHM,newFWHM,M,FSR]=MMR_pair_parameters_calculation(a,r,L,neff,i,delta_n0,ng0,lambda,lambda0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% parameter annotation %%%%%%%%%%%%%%%%%%%%%%%
% input parameters
% a: single-pass amplitude transmission coefficient
% r: self-coupling coefficient
% L: the total length of MRR,L must meet the resonace condition of MRR
% lambda,neff: the dispersion curve
% i; the i-th wavelength channel
% delta_n0: the effective index change to get a required phase difference between two arms
% lambda0: the center wavelength of the target wavelength channel
% ng0: the group index corresponding to lambda0

% output parameters
% delta_lambda_b0_min: resonance wavelength shift after blue shift
% delta_lambda_r0_min: resonance wavelength shift after red shift
% FWHM: 
% newFWHM:
% M; similar to Finesse
% FSR: free spectrum range


% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Give the phase and amplitude of the Transmission of the blushifts MRR ans redshift MRR
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %assuming thermal or electrical tunning leads to 
% % % %constant effective index change for all the wavelength

[T0]=single_mrr_accurate(a,r,L,lambda,neff(:,i));
 neff1=neff(:,i)+delta_n0;
 neff2=neff(:,i)-delta_n0;
% 
% Cross state
[T1]=single_mrr_accurate(a,r,L,lambda,neff1);
[T2]=single_mrr_accurate(a,r,L,lambda,neff2);



% Bar state
[T3]=single_mrr_accurate(a,r,L,lambda,neff2);
[T4]=single_mrr_accurate(a,r,L,lambda,neff1);





% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % Calculate the new resonace wavelength after red shift % % % % % %
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[izero_lambda_r0,all_lambda_r0,min_lambda_r0]=find_0_point(lambda,sin(T1.angle));
izero_lambda_r0_size=size(izero_lambda_r0);
delta_lambda_r0=zeros(izero_lambda_r0_size(1),1);

for i=1:1:izero_lambda_r0_size(1)
    
delta_lambda_r0(i)=abs(all_lambda_r0(i)-lambda0);

end
delta_lambda_r0_min=min(delta_lambda_r0);

% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % Calculate the new resonace wavelength after blue shift % % % % % %
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[izero_lambda_b0,all_lambda_b0,min_lambda_b0]=find_0_point(lambda,sin(T2.angle));
izero_lambda_b0_size=size(izero_lambda_b0);
delta_lambda_b0=zeros(izero_lambda_b0_size(1),1);

for i=1:1:izero_lambda_b0_size(1)
    
delta_lambda_b0(i)=abs(all_lambda_b0(i)-lambda0);

end
delta_lambda_b0_min=min(delta_lambda_b0);


%%%%%%%%%%%%%give FWHM,FSR,M,newFWHM%%%%%%%%%%%%%%
delta_lambda_rb=delta_lambda_b0_min+delta_lambda_r0_min
FWHM=(1-r*a).*lambda0^2./(pi*ng0*L.*sqrt(r*a))
newFWHM=FWHM+delta_lambda_rb
FSR=lambda0^2/(ng0*L)
M=FSR/newFWHM

