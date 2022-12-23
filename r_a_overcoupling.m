aj=12;
rk=12;
a=linspace(0.87,0.98,12);
r=linspace(0.86,0.97,12);
for j=1:1:aj
    for k=1:1:rk
        if (a(j)>r(k))
        s=a(j);
        t=r(k);
        [s,t]
        end
    end
end
