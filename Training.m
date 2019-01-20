load LDP_train_B
load HSV_train_B
load jumkeyframe_B %jumkeyframe per video
load indextotal_B %index with-in video
load listBatas_B %batas indeks antar video
load totalkeyframe_B %total keyframe
load MatrixP_fusion_B

%Hash code length
l = 100;

%Parameter Optimisasi (Harus dituning nilainya)
T = 50; %Jumlah iterasi (Kalo terlalu besar bisa offset/overfitting, Kalo terlalu kecil bisa jadi belum optimal)
learningrate = 0.01;
momentum = 0.1;
balancing = 0.9;

%Inisialisasi nilai bobot LDP
bobotmax = 1;
bobotmin = -1;
bobotBEFORE_ldp(size(LDP_train,2),l) = 0;
bobot_ldp = (bobotmax-bobotmin).*rand(size(LDP_train,2),l)+bobotmin; %hash code length = 100

%Inisialisasi nilai bobot HSV
bobotBEFORE_hsv(162,l) = 0;
bobot_hsv = (bobotmax-bobotmin).*rand(162,l)+bobotmin; %hash code length = 100

%Inisialisasi nilai bias
biasBEFORE(1,l) = 0;
bias(1,l) = 0;

%Hitung Matrix P
%MatrixP = HitP(LDP_train,HSV_train,totalkeyframe,indextotal);


for t=1:T
    tic;
    string = ['iterasi=',num2str(t)];
    disp(string);
    %Hitung Z hashcodes dan ciriTOTAL
    [outputZ,ztotal] = kodeZ(totalkeyframe,bobot_ldp,bobot_hsv,bias,LDP_train,HSV_train);
    %Hitung Matrix Q
    disp('Hitung Q');
    [MatrixQ,pembilangQ] = HitQ(outputZ,totalkeyframe);
    %Hitung Gradient Descent
    disp('Gradient Descent');
    [dOdW_ldp,dOdW_hsv,dOdB] = GradientDescent(l,MatrixP,MatrixQ,pembilangQ,outputZ,HSV_train,LDP_train,balancing,totalkeyframe);
    
    %Set the updates :
        %Update bobotNEXT
        bobotNEXT_ldp = bobot_ldp + learningrate*dOdW_ldp + momentum*(bobot_ldp - bobotBEFORE_ldp);
        bobotNEXT_hsv = bobot_hsv + learningrate*dOdW_hsv + momentum*(bobot_hsv - bobotBEFORE_hsv);
        %Update biasNEXT
        biasNEXT = bias + learningrate*dOdB + momentum*(bias - biasBEFORE);
    
   %update bobot ldp    
    bobotBEFORE_ldp = bobot_ldp;
    bobot_ldp = bobotNEXT_ldp;
    %update bobot hsv
    bobotBEFORE_hsv = bobot_hsv;
    bobot_hsv = bobotNEXT_hsv;
    %update bias
    biasBEFORE = bias;
    bias = biasNEXT;
    
    %display
    totalW1=abs(dOdW_hsv);
    totalW2=abs(dOdW_ldp);
    totalB=abs(dOdB);
    iterasiW1 = sum(totalW1(:));
    iterasiW2 = sum(totalW2(:));
    iterasiB = sum(totalB(:));
    listW1(t,1) = iterasiW1;
    listW2(t,1) = iterasiW2;
    listB(t,1) = iterasiB;
    s2 = num2str(listW1(t,1));
    disp(s2);
    toc;
    waktu_1_iterasi = toc;
    
end

[outputZ,ztotal] = kodeZ(totalkeyframe,bobot_ldp,bobot_hsv,bias,LDP_train,HSV_train);


%Buat Binary Hash Code untuk video
averageH = zeros(50,l);
outputZvideo = outputZ(1 : listBatas(1,1), :);
averageH(1,:) = sum(outputZvideo)/jumkeyframe(1,1) ;%indeks ke-1

for indeks=1:49
    clear outputZvideo
    outputZvideo = outputZ(listBatas(indeks,1)+1 : listBatas(indeks+1,1) , :);
    averageH(indeks+1,:) = sum(outputZvideo)/jumkeyframe(indeks,1);
end

for video=1:50
    for length=1 : l
        if averageH(video,length) > 0.5
         KodeLatih(video,length) = 1;
        else
         KodeLatih(video,length) = 0;
        end
    end
end

save('KodeLatih50_B.mat','KodeLatih');
%MODEL
save('l.mat','l');
save('T.mat','T');
save('learningrate.mat','learningrate');
save('momentum.mat','momentum');
save('balancing.mat','balancing');
save('bobot_hsv_50_B.mat','bobot_hsv');
save('bobot_ldp_50_B.mat','bobot_ldp');
save('bias50_B.mat','bias');
save('listW1_50_B.mat','listW1');
save('listW2_50_B.mat','listW2');
save('listB_50_B.mat','listB');
%save('MatrixP.mat','MatrixP');
save('MatrixQ_50_B.mat','MatrixQ');