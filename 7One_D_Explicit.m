% -------------------------------------------------
% 1D Unsteady Heat Conduction in a Rod
% Explicit (FTCS) Method
% dT/dt = k * d2T/dx2
% -------------------------------------------------

clc
clear

L = 1.0;          % Length of rod (m)
k = 0.01;         % Thermal diffusivity (m^2/s)

%% Numerical parameters
Nx = 21;                  % Number of spatial nodes
dx = L/(Nx-1);            % Spatial step
dt = 0.4*dx^2/k;          % Time step (chosen to satisfy stability) dt_max -> 0.5
Nt = 1000;                 % Number of time steps

T = zeros(Nx,1);          % Initial temperature = 0 everywhere
T(:) = 20;                % Uniform initial temperature (°C)
T(1)= 400;
T(Nx)= 300;

lembda = k*dt/dx^2;            % Stability parameter

% Check stability
if lembda > 0.5
    error('Stability condition violated: lembda must be <= 0.5');
end

for t=1:Nt
    TO = T;
    for i = 2:Nx-1
        T(i)=lembda*(TO(i+1)+TO(i-1))+(1-2*lembda)*TO(i);
    end
end

%% Plot result

x = linspace(0, L, Nx);

figure;
plot(x, T, 'r-o', 'LineWidth', 2);
xlabel('Position x (m)');
ylabel('Temperature T (°C)');
title('1D Unsteady Heat Conduction (Explicit Method)');
grid on;





