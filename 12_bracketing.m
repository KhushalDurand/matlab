% Bisection Method to find root of f(x)

clc;
clear;

f = @(x) x^3 - x - 2;   

a = 1;                  
b = 2;                 
tol = 1e-6;            
max_iter = 100;        

if f(a)*f(b) > 0
    disp('Invalid interval. f(a) and f(b) must have opposite signs.');
else
    for i = 1:max_iter
        1. bisection
        c = (a + b)/2;  
        2. false position
        m = (f(xu)-f(xl))/(xu-xl);
        c = xl - f(xl)/m;
        
        if abs(f(c)) < tol
            break;
        end
        
        if f(a)*f(c) < 0
            b = c;
        else
            a = c;
        end
    end
    
    fprintf('Root = %.6f\n', c);
    fprintf('Iterations = %d\n', i);
end



