load LDP_Uji3
load LDP_Uji4
load HSV_Uji3
load HSV_Uji4

load bobot_hsv_150_B
load bobot_ldp_150_B
load bias150_B
load l

%Query ke-3
n1 = size(LDP_1,1);
[outputZ,ztotal] = kodeZ(n1,bobot_ldp,bobot_hsv,bias,LDP_1,HSV_1);

%Buat Binary Hash Code untuk video
averageH1 = sum(outputZ)/n1 ;

for length=1 : l
    if averageH1(1,length) > 0.5
        KodeUji3(1,length) = 1;
    else
        KodeUji3(1,length) = 0;
    end
end

%Query ke-4
n2 = size(LDP_26,1);
[outputZ,ztotal] = kodeZ(n2,bobot_ldp,bobot_hsv,bias,LDP_26,HSV_26);

%Buat Binary Hash Code untuk video
averageH2 = sum(outputZ)/n2 ;

for length=1 : l
    if averageH2(1,length) > 0.5
        KodeUji4(1,length) = 1;
    else
        KodeUji4(1,length) = 0;
    end
end

save('KodeUji3_150_B.mat','KodeUji3');
save('KodeUji4_150_B.mat','KodeUji4');