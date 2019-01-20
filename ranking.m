load KodeLatih150_B
load KodeUji3_150_B
load KodeUji4_150_B

code1 = KodeLatih(1:25,:); %split matrix

for z=1:25
    b1 = code1(z,:);
    HammingQuery3(z,1) = hammingDist(KodeUji3,b1);
end
[p,rankQ3]= sort(HammingQuery3);

code2 = KodeLatih(26:50,:); %split matrix

for z=1:25
    b2 = code2(z,:);
    HammingQuery4(z,1) = hammingDist(KodeUji4,b2);
end
[i,rankQ4]= sort(HammingQuery4);

save('rankQ3_150_B.mat','rankQ3');
save('rankQ4_150_B.mat','rankQ4');