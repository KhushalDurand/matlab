clc;
clear;

% Input data
x = [1 4 5 6];
y = log(x);

n = length(x);
xp = 2;   % Point where interpolation is required

P = 0;    % Initialize polynomial value

for i = 1:n
    L = 1;   % Lagrange basis polynomial
    
    for j = 1:n
        if j ~= i
            L = L * (xp - x(j)) / (x(i) - x(j));
        end
    end
    
    P = P + y(i) * L;
end

P
