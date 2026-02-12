clc; clear;

%% Grid
Nx = 5;      
Ny = 5;
Nt = 2000;

dx = 1;
alpha = 1;
dt = 0.1;

lambda = alpha*dt/dx^2;

%% Initialize Temperature
T = zeros(Ny, Nx);

% Boundary Conditions (j = row index)
T(:,1)   = 50;      % Left
T(:,Nx)  = 150;     % Right
T(1,:)   = 100;     % Top  (j=1)
T(Ny,:)  = 0;       % Bottom (j=Ny)
T

%% Internal node count
n_int_x = Nx-2;   
n_int_y = Ny-2;   
N = n_int_x * n_int_y;

%% Build coefficient matrix A

A = zeros(N,N);

for j = 1:n_int_y
    for i = 1:n_int_x
        
        k = (j-1)*n_int_x + i;   
        A(k,k) = 1 + 4*lambda;
        
        % left
        if i > 1
            A(k, k-1) = -lambda;
        end
        
        % right
        if i < n_int_x
            A(k, k+1) = -lambda;
        end
        
        % top (row above → smaller j)
        if j > 1
            A(k, k-n_int_x) = -lambda;
        end
        
        % bottom (row below → larger j)
        if j < n_int_y
            A(k, k+n_int_x) = -lambda;
        end
    end
end

%% Time Loop
for n = 1:Nt
    
    b = zeros(N,1);
    
    for j = 1:n_int_y
        for i = 1:n_int_x
            
            k = (j-1)*n_int_x + i;
            
            global_i = i+1;      % column
            global_j = j+1;      % row
            
            b(k) = T(global_j, global_i);
            
            % ---- Correct boundary contributions ----
            
            % Left boundary
            if i == 1
                b(k) = b(k) + lambda*T(global_j,1);
            end
            
            % Right boundary
            if i == n_int_x
                b(k) = b(k) + lambda*T(global_j,Nx);
            end
            
            % Top boundary  (j == 1 → touches row 1)
            if j == 1
                b(k) = b(k) + lambda*T(1,global_i);
            end
            
            % Bottom boundary (j == n_int_y → touches row Ny)
            if j == n_int_y
                b(k) = b(k) + lambda*T(Ny,global_i);
            end
        end
    end
    
    T_internal = A \ b;
    
    % Map back correctly (j=row, i=col)
    for j = 1:n_int_y
        for i = 1:n_int_x
            
            k = (j-1)*n_int_x + i;
            T(j+1, i+1) = T_internal(k);
            
        end
    end
end

disp(T)
