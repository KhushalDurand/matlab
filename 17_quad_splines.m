clc;
clear;

x = linspace(-1,1,10);
y = 1./(1+25.*x.*x);

n  = length(x);
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


clc;
clear;

x = linspace(-1,1,10);
y = 1./(1+25.*x.*x);

n = length(x);
h = diff(x);

%% matrix for b

A = zeros(n-1,n);
B = zeros(n-1,1);

for i = 1:n-1
    A(i,i)   = h(i);
    A(i,i+1) = h(i);
    B(i) = 2*(y(i+1)-y(i));
end

%% solve b
b = pinv(A)*B;     % because matrix is rectangular

%% compute c

c = zeros(n-1,1);

for i = 1:n-1
    c(i) = (b(i+1)-b(i))/(2*h(i));
end

a = y(1:n-1)';
