function res = tau_estrap(tau,d,dd,o,N)
%Bootstrap approach to polynomial fit (second degree)
if (nargin<5 || isempty(N))
    N = 1000;
end

if (nargin<4 || isempty(o)&&isempty(N))
    o = 1;
    N = 1000;
end

aa = [];
bb = [];
cc = [];


for i = 1:N
    ad = d + dd.*randn(size(dd));
    aux = polyfit(tau,ad,o);
    aa = [aa aux(end)];
    bb = [bb aux(2)];
    cc = [cc aux(1)];
end


res(3,1) = mean(aa);
res(3,2) = std(aa);

res(2,1) = mean(bb);
res(2,2) = std(bb);

res(1,1) = mean(cc);
res(1,2) = std(cc);