function CC= gap(ret,ll)
CC(1) = mean(mean(ret.*ret,2));
RR = [ret(:,2:end) ret(:,1)];
CC(2) = mean(mean(ret.*RR,2));
for i=3:ll
RR = [RR(:,2:end) RR(:,1)]; CC(end+1) = mean(mean(ret.*RR,2)); DD=std(mean(ret.*RR,2));
end

count = 1;
while CC(count)>CC(1)/100 && count<ll && CC(count)>0 
    count=count+1;
end
    

% res = polyfit(0:count-1,log(CC(1:(count))),1);
end


