% jacobian for newton repson method

function [A,B] = jacobian(X)
   x = X(1);
   y=X(2);

f1 = 2*x^2 + 3*y - 2;
f2 = 2*y^2 - 4*x*y + 8;

B=[f1 ; f2];

A11=4*x;
A21=-4*y;
A12=3;
A22=4*y-4*x;

A =[A11 A12; A21 A22];

end
clc;
clear;
max_iter=100;
tol = 1e-6;
X = [1;1];

for i=1:max_iter
    [A,B]=jacobian(X);
    del_x = A\(-B);
    X = del_x + X;

    % Convergence check
    if norm(del_x,2) < tol && norm(B,2) < tol
        fprintf('Converged Successfully\n');
        fprintf('x = %.6f\n', X(1));
        fprintf('y = %.6f\n', X(2));
        fprintf('Iterations = %d\n', k);
        return
    end
end

fprintf('Method did NOT converge in %d iterations\n', max_iter);

fprintf('Method did NOT converge in %d iterations\n', max_iter);
