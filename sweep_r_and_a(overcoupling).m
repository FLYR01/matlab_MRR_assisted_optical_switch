a=linspace(0.87,0.98,12);
r=linspace(0.86,0.97,12);
for i=1:1:12
    for j=1:1:12
        if (a(i)>r(j))
            s=a(i);
            t=r(j);
            [s,t]
        end
    end
end