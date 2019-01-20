
function [dist] = hausdorff( A, B) 
if(size(A,2) ~= size(B,2)) 
    fprintf( 'WARNING: dimensionality must be the same\n' ); 
    dist = []; 
    return; 
end
dist = max(compute_dist(A, B), compute_dist(B, A));

%% Compute distance
function[dist] = compute_dist(A, B) 
m = size(A, 1); %ukuran baris
n = size(B, 1); %ukuran baris
dim= size(A, 2); %ukuran kolom
for k = 1:m 
    C = ones(n, 1) * A(k, :); %ones buat bkin matrix n baris.1 kolom dengan nilai 1,, A(k,:)=nilai baris ke k untuk semua kolom
    D = (C-B) .* (C-B); 
    D = sqrt(D * ones(dim,1)); 
    dist(k) = min(D); 
end
dist = max(dist);
