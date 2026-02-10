clear; clc;

%% -------- Physical & Numerical Parameters --------
Lx = 1;              % Length in x
Ly = 1;              % Length in y
Nx = 20;             % Grid points in x
Ny = 20;             % Grid points in y
alpha = 0.01;        % Thermal diffusivity
Nt = 2000;           % Time steps
dt = 0.001;          % Time step size

dx = Lx/(Nx-1);
dy = Ly/(Ny-1);

lx = alpha*dt/dx^2;
ly = alpha*dt/dy^2;

% Stability check
if lx + ly > 0.5
    error('Stability condition violated: reduce dt');
end

%% -------- Initialization --------
T = zeros(Ny,Nx);    % (row = y, column = x)

% Boundary conditions (Dirichlet)
T(:,1)      = 50;    % Left
T(:,Nx)     = 80;    % Right
T(1,:)      = 50;    % Bottom
T(Ny,:)     = 150;   % Top

%% -------- Time Marching --------
for t = 1:Nt
    T_old = T;

    for j = 2:Ny-1
        for i = 2:Nx-1
            T(j,i) = T_old(j,i) ...
                   + lx*(T_old(j,i-1) + T_old(j,i+1) - 2*T_old(j,i)) ...
                   + ly*(T_old(j-1,i) + T_old(j+1,i) - 2*T_old(j,i));
        end
    end
end

%% -------- Grid for Plotting --------
x = linspace(0,Lx,Nx);
y = linspace(0,Ly,Ny);
[X,Y] = meshgrid(x,y);

%% -------- Surface Plot --------
figure;
surf(X,Y,T,'EdgeColor','none');
colorbar;
xlabel('x'); ylabel('y'); zlabel('Temperature');
title('2D Heat Conduction (Explicit Scheme)');
view(45,30);

%% -------- Contour Plot --------
figure;
contourf(X,Y,T,20);
colorbar;
xlabel('x'); ylabel('y');
title('Temperature Contours');
