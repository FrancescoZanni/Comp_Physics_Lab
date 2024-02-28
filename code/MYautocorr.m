function CC = MYautocorr(d,tt)
%Autocorrelation function
T = length(d);

for t = 0:tt
    CC(t+1) = mean(d(1:(T-t)).*d((1+t):T));
end

CC = CC - (mean(d))^2;

CC = CC/CC(1);

end