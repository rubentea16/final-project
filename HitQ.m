function [MatrixQ,pembilangQ] = HitQ(outputZ,totalkeyframe)

%Hitung Pembilang Matrix Q
for a=1:totalkeyframe
    for b=1:totalkeyframe
        if a~=b
        Z1= outputZ(a,:);
        Z2= outputZ(b,:);
        EuDist = (Z1-Z2).^2; %euclidian distance kuadrat
        totalhash = sum(EuDist(:));
       
        summaryQ(a,b) = (totalhash+1);
        pembilangQ(a,b) =(summaryQ(a,b)^(-1));
        end
        if a==b
           pembilangQ(a,b)=0;
        end
    end
end


%Hitung Penyebut Matrix Q
 penyebutQ = sum(pembilangQ(:));
 MatrixQ = pembilangQ / penyebutQ;
        
%Normalize matrix peluang ny supaya total nya 1
 MatrixQ = MatrixQ ./ sum(MatrixQ(:));