% -------------------------------------------------
% 1D Unsteady Heat Conduction in a Rod
% Implicit (BTCS) Method
% dT/dt = k * d2T/dx2
% -------------------------------------------------

% clc; clear;

%% Physical parameters
L = 1.0;          % Length of rod (m)
k = 0.01;         % Thermal diffusivity (m^2/s)

%% Numerical parameters
Nx = 20;                  % Number of spatial nodes
dx = L/(Nx-1);            % Spatial step
dt = 1.0;                 % Time step (can be large, implicit is stable)
Nt = 500;                 % Number of time steps

lembda = k*dt/dx^2;


%% Initial condition
in = Nx-2;
T = 20*ones(in,1);        % Initial uniform temperature (°C)

%% Boundary conditions (Dirichlet)
T_left = 400;
T_right =300;

%% Coefficient matrix A (tridiagonal)
A = zeros(in, in);

% Interior nodes

for i = 1:in
    if i~=1
    A(i, i-1) = -lembda;
    end
    A(i, i)   = 1 + 2*lembda;
    if i~=in
    A(i, i+1) = -lembda;
    end
end

%% Time marching
for n = 1:Nt
    b = T;                % Right-hand side

    % Apply boundary conditions in RHS
    b(1)   = T(1)+lembda*T_left;
    b(end) = T(in)+lembda*T_right;

    % Solve linear system: A * T_new = b
    T = A \ b;   % chooses the best method (LU, Cholesky, QR, etc.) to solve for T
end

T = [T_left; T; T_right];

%% Grid
x = linspace(0, L, Nx);

figure;
plot(x, T, 'r-o', 'LineWidth', 2);
xlabel('Position x (m)');
ylabel('Temperature T (°C)');
title('1D Unsteady Heat Conduction (Explicit Method)');
grid on;

