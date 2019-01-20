function [outputZ,ztotal] = kodeZ(totalkeyframe,bobot_ldp,bobot_hsv,bias,LDP_train,HSV_train)

%bobot * ciri
   z1 = LDP_train * bobot_ldp;
   z2 = HSV_train * bobot_hsv;

   ztotal = z1+z2;
   
   for a=1:totalkeyframe
       ztotal(a,:) = ztotal(a,:) + bias;
   end
   
   %Normalize ztotal agar berada pada active range sigmoid function yaitu
   %[-4,4]
   %Normalize to [0,1]
        ztotal = (ztotal - min(ztotal(:))) /(max(ztotal(:))-min(ztotal(:)));
   %Normalize to [-4,4]
        ztotal = (ztotal*8)-4;
   
   %Activation Function : Sigmoid
   Z=logsig(ztotal);

   outputZ = Z;