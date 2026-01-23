% GAUSS-SEIDEL METHOD (GENERAL n x n)
% x=1
% Y=3
% Z=2
clc
clear


A = [ 8 -1 1; 2 12 -1; 3 2 9];     % diagonal dominant matrix
B = [7; 36; 27];
[N,~]= size(A);
X = zeros(N,1);
tol = 1e-6;
max_iter = 1000;

for i = 1:max_iter
    x_old = X;
    for i = 1:N
        sum1 = A(i,1:i-1)*X(1:i-1);
        sum2 = A(i,i+1:N)*x_old(i+1:N);
        X(i)= (B(i)-sum1-sum2)/A(i,i);
    end
    if norm(X-x_old,inf)<tol
        fprintf("convernges in %d iteration\n",i)
        break
    end
end

% euclidean disttance
d = sqrt(X.*X-x_old*x_old)

