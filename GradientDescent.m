function [dOdW_ldp,dOdW_hsv,dOdB] = GradientDescent(l,MatrixP,MatrixQ,pembilangQ,outputZ,HSV_train,LDP_train,balancing,totalkeyframe)

%Log MatrixQ/MatrixP
tes = log(MatrixQ);
tes1 = log(MatrixP);
for a=1:totalkeyframe
    for b=1:totalkeyframe
        if tes(a,b) == -inf
            tes(a,b) = 0;
        end
        if tes1(a,b) == -inf
           tes1(a,b) = 0;
        end
    end
end
logMatrix = tes - tes1;

%Derivate of Kode Hash to Bias
dZdB = outputZ .* (1-outputZ);

%dit = dti = zi-zt
%Selisih Kode Hash antar keyframe
for i=1:totalkeyframe
    for t=1:totalkeyframe
        if i~=t
            Z1= outputZ(i,:);
            Z2= outputZ(t,:);
            selisih = Z1-Z2;
            selisih = sum(selisih(:));
            selisihZ(i,t)= selisih; %pers (34)
        end
    end
end

%Derivate of KullbackLeibler-1 to Kode Hash
sumKL1 = (MatrixP - MatrixQ).*pembilangQ.*selisihZ;
sumKL1 = sum(sumKL1,2);
dKL1dZi = 4*sumKL1; % Pers (34), ukuran matriks jumkeyframe X 1
    
%Derivate of KullbackLeibler-2 to Kode Hash    
kl = (MatrixQ.*logMatrix);
sumkl = sum(kl(:));
%--  
sumKL2 = MatrixQ .*(sumkl - logMatrix) .*selisihZ .* pembilangQ;    
sumKL2 = sum(sumKL2,2);
dKL2dZi = 4*sumKL2; %pers (35), ukuran matriks jumkeyframe X 1
    
%Buat dKL1dZil dan dKL2dZil
dKL1dZil = repmat(dKL1dZi,1,l);
dKL2dZil = repmat(dKL2dZi,1,l);
    
%Compute Gradient Descent
dX = (balancing.*dKL1dZi + (1-balancing).*dKL2dZi);
dOdB = dX' * dZdB;
dOdW_ldp = LDP_train' * (dZdB.*(balancing.*dKL1dZil + (1-balancing).*dKL2dZil));
dOdW_hsv = HSV_train' * (dZdB.*(balancing.*dKL1dZil + (1-balancing).*dKL2dZil));