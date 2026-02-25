clc;
clear;

% Given data points
x = [1 4 5 6];
y = log(x);

n = length(x);

% Construct Vandermonde matrix
V = zeros(n,n);

for i = 1:n
    for j = 1:n
        V(i,j) = x(i)^(n-j);
    end
end

% Solve for coefficients
a = V \ y';   % Polynomial coefficients

disp(a)

% Interpolation at a given point
xp = 2;
P = 0;

for i = 1:n
    P = P + a(i) * xp^(n-i);
end

P
