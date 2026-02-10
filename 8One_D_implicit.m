% -------------------------------------------------
% 1D Unsteady Heat Conduction in a Rod
% Implicit (BTCS) Method
% dT/dt = k * d2T/dx2
% -------------------------------------------------

clc; clear;


L = 1.0;          
k = 0.01;         

%% Numerical parameters
Nx = 20;                  
dx = L/(Nx-1);          
dt = 1.0;                 % Time step (can be large, implicit is stable)
Nt = 500;                 

lembda = k*dt/dx^2;

T = zeros(Nx-2,1);        

%% Boundary conditions (Dirichlet)
T_left = 400;
T_right =300;

%% Coefficient matrix A (tridiagonal)
A = zeros(Nx-2, Nx-2);

% Interior nodes
for i = 1:Nx-2
    if i~=1
    A(i, i-1) = -lembda;
    end
    A(i, i)   = 1 + 2*lembda;
    if i~=Nx-2
    A(i, i+1) = -lembda;
    end
end

%% Time marching
for n = 1:Nt

    b = T;               
    b(1)   = T(1)+lembda*T_left;
    b(end) = T(end) + lembda*T_right;

    T = A \ b;   % chooses the best method (LU, Cholesky, QR, etc.) to solve for T
end

T = [T_left; T; T_right];

%% Grid
x = linspace(0, L, Nx);
T

figure;
plot(x, T, 'r-o', 'LineWidth', 2);
xlabel('Position x (m)');
ylabel('Temperature T (°C)');
title('1D Unsteady Heat Conduction (Explicit Method)');
grid on;


