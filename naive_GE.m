% NAIVE GAUSS ELIMINATION
%  x = 1, y = 3, z = 2

A = [2 3 -2; 1 1 1; 3 -1 2];
B = [7;6;4];
[n,~] = size(A);
X = zeros(n,1);

% FORWARD ELIMINATION
for i = 1: n-1
    m = A(i+1:n,i)/A(i,i);
    % A(i+1:n,:)= A(i+1:n,:)- m*A(i,:);  // extra flop calculation
    A(i+1:n,i+1:n)= A(i+1:n,i+1:n)- m*A(i,i+1:n);
    B(i+1:n)=B(i+1:n)-m*B(i);
end 

   X(n)=B(n)/A(n,n);

for i = n-1:-1:1
    X(i)=(B(i)-A(i,i+1:n)*X(i+1:n,:))/A(i,i);

end

X
