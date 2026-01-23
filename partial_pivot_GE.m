% GAUSS ELIMINATION FOR PARTIAL PIVOT
%  = 1, y = 3, z = 2

A = [2 3 -2; 1 1 1; 3 -1 2];
B = [7;6;4];
[n,~] = size(A);
X = zeros(n,1);
AUG = [A B];

% partial pivoting
for i = 1:n-1
    [~,p]=max(abs(AUG(i:n,i)));
    p = p + i-1;

    if p~=i
        AUG([i p],:)=AUG([p i],:);
    end
    
    % elimination
    for j =i+1:n
        m = AUG(j,i)/AUG(i,i);
        % A(i+1:n,:)= A(i+1:n,:)- m*A(i,:);  // extra flop calculation
        AUG(j,i+1:n+1) = AUG(j,i+1:n+1) - m*AUG(i,i+1:n+1);
        
    end
end

X(n)=AUG(n,n+1)/AUG(n,n);

for i = n-1:-1:1
    X(i)=(AUG(i,n+1)-AUG(i,i+1:n)*X(i+1:n))/AUG(i,i);

end

X