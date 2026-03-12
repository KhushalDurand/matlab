clc;
clear;

x = linspace(-1,1,10);
y = 1./(1+25.*x.*x);

n = length(x);
h = diff(x);

%% compute matrix for b

A = zeros(n-1,n);
B = zeros(n-1,1);
A(1,1)=h(1);
B(1,1)=y(2)-y(1);

for i = 2:n-1
    A(i,i) = h(i);
    A(i,i-1) = h(i);
    B(i) = 2*(y(i+1)-y(i));
end

%% solve for b

b = pinv(A)*B;

%% compute c

c = zeros(n-1,1);

for i = 1:n-1
    c(i) = (b(i+1)-b(i))/(2*h(i));
end

a = y(1:n-1)';

%% generate interpolation points

xp = linspace(-1,1,200);
yp = zeros(size(xp));

for j = 1:length(xp)
    for i = 1:n-1
        if xp(j) >= x(i) && xp(j) <= x(i+1)
            dx = xp(j) - x(i);
            yp(j) = a(i) + b(i)*dx + c(i)*dx^2;
            break
        end
    end
end

%% plot

plot(xp,yp,'r','LineWidth',1.5)
hold on
plot(x,y,'ob','MarkerFaceColor','b')
grid on
title('Quadratic Spline Interpolation')
legend('Quadratic spline','Data points')
