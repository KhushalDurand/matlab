function dydx = ode_system(x, y)
% y is a column vector:
% y(1) = y1, y(2) = y2

dydx = zeros(2,1);

dydx(1) = y(2);     % dy1/dx = y2
dydx(2) = -y(1);    % dy2/dx = -y1

end

clc;
clear;

% Initial conditions
x0 = 0;
y0 = [0; 1];   % y1(0)=0, y2(0)=1

% Step size and number of steps
h = 0.1;
n = 50;

% Initialize
x = zeros(1, n+1);
y = zeros(2, n+1);

x(1) = x0;
y(:,1) = y0;

% Euler Method for system
for i = 1:n
    x(i+1) = x(i) + h;
    y(:,i+1) = y(:,i) + h * ode_system(x(i), y(:,i));
end

% Display results
disp('   x        y1        y2');
disp([x' y(1,:)' y(2,:)'])

% Plot results
plot(x, y(1,:), '-o', x, y(2,:), '-x');
legend('y1','y2');
xlabel('x');
ylabel('Solution');
title('Euler Method for System of ODEs');
grid on;
