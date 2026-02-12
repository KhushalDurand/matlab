

%% Grid
Nx = 5;      
Ny = 5;
Nt =2000;

dx = 1;
alpha = 1;
dt = 0.1;

lambda = alpha*dt/dx^2;

%% Initialize
T = zeros(Ny, Nx);

% Boundary Conditions
T(:,1)   = 50;    % Left
T(:,Nx)  = 150;   % Right
T(1,:)   = 100;     % Top
T(Ny,:)  = 0;   % Bottom

%% ---- Precompute constant tridiagonal matrices ----
n_int_x = Nx-2;   % 3
n_int_y = Ny-2;   % 3

% Same structure for both directions (since lambda_x = lambda_y)

Ax = diag((1+2*lambda)*ones(n_int_x,1)) ...
   + diag(-lambda*ones(n_int_x-1,1),1) ...
   + diag(-lambda*ones(n_int_x-1,1),-1);

Ay = diag((1+2*lambda)*ones(n_int_y,1)) ...
   + diag(-lambda*ones(n_int_y-1,1),1) ...
   + diag(-lambda*ones(n_int_y-1,1),-1);

%% Time Loop
for n = 1:Nt
    
    T_half = T;
    
    %% ---- Step 1: Explicit x, Implicit y ----
    for i = 2:Nx-1
        
        b = zeros(n_int_y,1);
        
        for j = 2:Ny-1
            idx = j-1;
            
            b(idx) = T(j,i) + ...
                lambda*(T(j,i+1) - 2*T(j,i) + T(j,i-1));
        end
        
        % Boundary correction
        b(1)   = b(1)   + lambda*T(1,i);
        b(end) = b(end) + lambda*T(Ny,i);
        
        T_half(2:Ny-1,i) = Ay \ b;
    end
    
    %% ---- Step 2: Implicit x, Explicit y ----
    for j = 2:Ny-1
        
        b = zeros(n_int_x,1);
        
        for i = 2:Nx-1
            idx = i-1;
            
            b(idx) = T_half(j,i) + ...
                lambda*(T_half(j+1,i) - 2*T_half(j,i) + T_half(j-1,i));
        end
        
        % Boundary correction
        b(1)   = b(1)   + lambda*T_half(j,1);
        b(end) = b(end) + lambda*T_half(j,Nx);
        
        T(j,2:Nx-1) = Ax \ b;
    end
    
end

disp(T)
x = linspace(0, dx*(Nx-1), Nx);
y = linspace(0, dx*(Ny-1), Ny);
[X,Y] = meshgrid(x,y);

figure;
surf(X, Y, T)
shading interp
colorbar
xlabel('x')
ylabel('y')
zlabel('Temperature')
title('Temperature Distribution (Surface Plot)')
view(45,30)

figure;
contourf(X, Y, T, 20)   % 20 contour levels
colorbar
xlabel('x')
ylabel('y')
title('Temperature Distribution (Contour Plot)')
