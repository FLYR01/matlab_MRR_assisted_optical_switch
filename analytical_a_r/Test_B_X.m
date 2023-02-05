clear;
clc;
close all;
fun = @(x,c) 2*c*exp(-c.*(1-cos(x))).*cos(x);
c=5;
format long
q = integral(@(x) fun(x,c),0,pi/2,'RelTol',0,'AbsTol',1e-12);
solution=101;
B=zeros(solution,1);
cc=linspace(0,100,solution)';
for i=1:1:solution
    B(i)=integral(@(x) fun(x,cc(i)),0,pi/2,'RelTol',0,'AbsTol',1e-12);
end

plot(cc,B);

B(100)