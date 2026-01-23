% Navie gauss elimination
% x = 1, y = 3, z = 2
% 2x +3y -2z = 7
% x + y + z = 6
% 3x -y + 2z = 4
% 
 A = [2 3 -2; 1 1 1; 3 -1 2];
 B = [7 ; 6 ; 4];
 [n,~] = size(A);

AUG=[A B];           % n * (n+1) 
X = zeros(n,1);

% FORWARD ELIMINATION
for i = 1: n-1
    m = AUG(i+1:n,i)/AUG(i,i);
    AUG(i+1:n,i+1:n+1)= AUG(i+1:n,i+1:n+1)- m*AUG(i,i+1:n+1);
end 

   X(n)=AUG(n,n+1)/AUG(n,n);

for i = n-1:-1:1
    X(i)=(AUG(i,n+1)-AUG(i,i+1:n)*X(i+1:n,:))/AUG(i,i);

end
X
