% GAUSS-SEIDEL METHOD (GENERAL n x n)
% x=1
% Y=3
% Z=2

A = [ 8 -1 1; 2 12 -1; 3 2 9];     % diagonal dominant matrix
B = [7; 36; 27];
[~,N]=size(A);
X = zeros(N,1);   % intial guess
tol = 1e-6;
max_iter = 1000;

figure
hold on
grid on


for  j= 1:max_iter
    OX = X;
    for i=1:N
        sum1= A(i,1:i-1)*X(1:i-1);
        sum2 = A(i,i+1:N)*OX(i+1:N);
        X(i) = (B(i)-sum1-sum2)/A(i,i);
    end
    if norm(X-OX,inf) < tol
        fprintf("convergence occur at %d iteration\n" , j)
        break
    end
    
    plot(1:N, X, '*-', 'DisplayName', ['Iter ' num2str(j)])  % this will plot X upto iteration where convergence occurs
 
end
legend

X
