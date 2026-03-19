% RK3 method

clc;
clear;

function dydx = ode_system(x, y)
    dy1dx = y(2);
    dy2dx = -y(1);
    dydx = [dy1dx; dy2dx]; 
end

h = 0.1;
n = 50;

x = 0:h:5;
y = zeros(2,n+1);

y(1,1) = 0;
y(2,1) = 1;

for i = 1:n
    k1 = ode_system(x(i), y(:,i));
    k2 = ode_system(x(i) + h/2, y(:,i) + (h/2)*k1);
    k3 = ode_system(x(i)+h,y(:,i)-k1*h+2*k2*h);
    
    y(:,i+1) = y(:,i) + (h/6)*(k1+4*k2+k3);
end

plot(x, y(1,:), '-o', x, y(2,:), '-x');
legend('y1','y2');
xlabel('x');
ylabel('Solution');
title('RK3 Method');
grid on;
