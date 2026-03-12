% direct interpolation

X = linspace(-1,1,5)'
Y = 1./(1+25.*X.*X)
n = length(X);
% 4th order polynomial required y = ax^4+bx^3+cx^2+dx^1+e;
row = zeros(n,1);
A = zeros(n,n);
B = Y;

for i = 1:n
    for j = 1:n
        A(i,j)=X(i)^(n-j);
    end
end
C = A\B;

% generating the interpolation points
xp = linspace(-1,1,100);
m = length(xp);
yp = zeros(m,1);

for i = 1:m
    yp(i)=0;
    for j =  1:n
        yp(i)=yp(i) + C(j)*xp(i)^(n-j);
    end
end

plot(xp,yp,"-r")





