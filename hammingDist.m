function Dh=hammingDist(B1, B2)

D = 0;
y = bitxor(B1,B2);
n = size(y,2);

for j = 1:n
   if y(1,j) == 1
        D = D+1;
   end
end
Dh = D;
