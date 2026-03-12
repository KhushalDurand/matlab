% open method: Newton method to find root

clc;
clear;

f      = @(x) x^3 - x - 2;   % function
f_dash = @(x) 3*x^2 - 1;     % derivative

tol = 1e-6;      % tolerance
max_iter = 1000; % maximum iterations

x = 0; % initial guess

for i = 1:max_iter
    if abs(f(x)) < tol
        fprintf("converged in %d iteration", i);
        break;
    end
    
    x = x - f(x)/f_dash(x);
end

x
