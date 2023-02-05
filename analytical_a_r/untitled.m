neff=2.234;
load('gap.mat')
load('no.mat')
[fitresult, gof] = createFit(gap, no,neff)