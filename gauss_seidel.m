% GAUSS-SEIDEL METHOD (GENERAL n x n)
% x=1
% Y=3
% Z=2

A = [ 8 -1 1; 2 12 -1; 3 2 9];     % diagonal dominant matrix
b = [7; 36; 27];

n = length(b);
x = zeros(n,1);        % initial guess
tol = 1e-6;
maxIter = 1000;

for iter = 1:maxIter
    x_old = x;

    for i = 1:n
        sum1 = A(i,1:i-1) * x(1:i-1);        % new values
        sum2 = A(i,i+1:n) * x_old(i+1:n);    % old values

        x(i) = (b(i) - sum1 - sum2) / A(i,i);
    end

    % convergence check
    if norm(x - x_old, inf) < tol
        fprintf('Converged in %d iterations\n', iter);
        break
    end
end

x
