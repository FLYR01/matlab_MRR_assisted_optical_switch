%%%%%%%%% read the file of neff.csv(effective index) amd ng.csv(group index) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% neff.csv amd ng.csv must have the same wavelenth point %%%%%%%%%%%%
%%%%%%%%% ng.csv:column1 is wavelength,column2 is ng %%%%%%%%%%%%%%%%%%%%
%%%%%%%%% neff.csv:column1 is wavelength,column2 is Re(neff),column3 is Im(neff) %%%%%%%%%%%%%%%%%%%%


function [Ng,Neff]=import_ng_neff(ng_file_name,neff_file_name)

ngfile = csvread(ng_file_name);
nefffile= csvread(neff_file_name);
Ng.lambda=ngfile(:,1).*(0.000001);
Ng.ng=ngfile(:,2);
Neff.lambda=nefffile(:,1).*(0.000001);% the unit of lambda is micron, here translate it to meter
Neff.neff=nefffile(:,2)+i*nefffile(:,3);

