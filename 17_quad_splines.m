clc;
clear;

% Data points
x = [3 4.5 7.0 9.0];
y = [2.5 1.0 2.5 0.5];

n = length(x);
h = diff(x);

a = y(1:n-1);     % a_i
b = zeros(n-1,1);
c = zeros(n-1,1);

% Natural condition
c(1) = 0;

% Compute coefficients
for i = 1:n-1
    if i == 1
        b(i) = (y(i+1)-y(i))/h(i);
    else
        b(i) = b(i-1) + 2*c(i-1)*h(i-1);
    end
    
    c(i) = ((y(i+1)-y(i)) - b(i)*h(i)) / (h(i)^2);
end

% Display splines
for i = 1:n-1
    fprintf('Spline %d on [%f , %f]\n',i,x(i),x(i+1));
    fprintf('S%d(x) = %f + %f(x-%f) + %f(x-%f)^2\n\n', ...
        i,a(i),b(i),x(i),c(i),x(i));
end
