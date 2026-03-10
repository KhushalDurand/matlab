clc;
clear;

x = linspace(-1,1,10);
y = 1./(1+25.*x.*x);
n = length(x);
D = zeros(n,n);
D(:,1)=y;

for j=2:n
    for i=1:n-j+1
        D(i,j) = (D(i+1,j-1)-D( i,j-1))/(x(i+j-1)-x(i));
    end
end

% generate interpolation points
xp = linspace(-1,1,100);
yp = zeros(size(xp));


for j = 1:length(xp)
    yp(j) = D(1,1);
    prod = 1;
     for i = 2:n
            prod = prod * (xp(j) - x(i-1));
            yp(j) = yp(j)+ D(1,i) * prod;
     end    
end
plot(xp,yp,'r','LineWidth',1.5)
hold on
plot(x,y,'ob','MarkerFaceColor','b')
grid on
