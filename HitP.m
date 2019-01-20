function MatrixP = HitP(LDP_train,HSV_train,totalkeyframe,indextotal)

%Hitung sigma untuk semua keyframe
for ciri=1:2
    for a=1:totalkeyframe
        if ciri == 1 %LDP
            sigma(a,ciri) = std(LDP_train(a,:));
        end
        if ciri == 2
            sigma(a,ciri) = std(HSV_train(a,:));
        end
    end
end
sigma = sigma.^2;


%Hitung LDP
for ciri = 1:2
    for a= 1:totalkeyframe 
        for b= 1:totalkeyframe
            if ciri == 1
                keyframe1 = LDP_train(a,:);
                keyframe2 = LDP_train(b,:);
            end
            if ciri == 2
                keyframe1 = HSV_train(a,:);
                keyframe2 = HSV_train(b,:);
            end
            if a~=b
            selisihkeyframe = (keyframe1 - keyframe2).^2; %Euclidian Distance Matriks
            summary(b,a) = sum(selisihkeyframe(:)); %Penjumlahan euclidian distance jadi 1 nilai 
            pembilangBA(b,a,ciri)= exp(-summary(b,a)/(2*sigma(a,ciri)));
            end
            if a==b
                pembilangBA(b,a,ciri)=0;
            end
        end
    end
end 

for ciri=1:2
    pembilang=pembilangBA(:,:,ciri);
    penyebutBA(1,ciri) = sum(pembilang(:));
    MatrixPba(:,:,ciri) = pembilangBA(:,:,ciri) / penyebutBA(1,ciri); %matrix P b|a
end


%HITUNG P a|b
for ciri=1:2
    MatrixPab(:,:,ciri) = transpose(MatrixPba(:,:,ciri));
end

%Hitung Jaccard Coefficient
for ciri=1:2
    for a=1:totalkeyframe
        for b=1:totalkeyframe
            if ciri == 1
                keyframe1 = LDP_train(a,:);
                keyframe2 = LDP_train(b,:);
            end
            if ciri == 2
                keyframe1 = HSV_train(a,:);
                keyframe2 = HSV_train(b,:);
            end
            if a~=b
            J(a,b,ciri) = size((intersect(keyframe1,keyframe2)),2) / size((union(keyframe1,keyframe2)),2);
            end
        end
    end
end

MatrixPc = (J.*(MatrixPba + MatrixPab));

%MatrixPw adalah matrix within video
for a=1:totalkeyframe
    for b=1:totalkeyframe
        if a~=b
            if indextotal(a,1) == indextotal(b,1)
                Pw(a,b)=1;
            end
        end
    end
end

MatrixPc = (MatrixPc(:,:,1)+MatrixPc(:,:,2))/(4);

MatrixP = (1-0.3)* (MatrixPc ./ sum(MatrixPc(:)))+ 0.3 * (Pw ./ sum(Pw(:))); %Normalize matrix peluang nya supaya 1
