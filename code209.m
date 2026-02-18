clc
clear

%% HEAT LOAD CALCULATION
% Required data
W_oil   = 56400;      
Cp_oil  = 0.545;     
dT_oil  = 258;         

W_water = 234350;      
Cp_water = 1.0;    
dT_water = 30;

% Calculation
% Formula: Q = W * Cp * deltaT
Q_oil   = W_oil * Cp_oil * dT_oil;
Q_water = W_water * Cp_water * dT_water;

% Output
fprintf('--- HEAT LOAD CALCULATION ---\n');
fprintf('Heat Load (Oil):   %.0f BTU/hr\n', Q_oil);
fprintf('Heat Load (Water): %.0f BTU/hr\n', Q_water);
fprintf('-------------------------------------------\n\n');


%% ================= LMTD CALCULATION =================
% Required data
dT1 = 238;             % deg F (358 - 120)
dT2 = 10;              % deg F (100 - 90)

% Calculation
% Formula: LMTD = (dT1 - dT2) / ln(dT1 / dT2)
num_lmtd = dT1 - dT2;
den_lmtd = log(dT1 / dT2);
LMTD = num_lmtd / den_lmtd;

% Output
fprintf('--- LMTD CALCULATION ---\n');
fprintf('Temperature Difference 1 (dT1): %.0f F\n', dT1);
fprintf('Temperature Difference 2 (dT2): %.0f F\n', dT2);
fprintf('Log Mean Temp Difference (LMTD): %.1f F\n', LMTD);
fprintf('-------------------------------------------\n\n');


%% ================= PRESSURE DROP CALCULATION =================
% Required data
f_s      = 0.00215;   
Gs       = 331764.7059;    
Ds       = 2.92;   
N_plus_1 = 42;         
De       = 0.0825;     
s        = 0.82;   
phi_s    = 0.92;      
v_sq_2g  = 0.13;      
n_passes = 4;         
S_tube   = 1;  

% Calculation
% --- 1. Shell-side Pressure Drop (Delta Ps) 
num_s = f_s * (Gs^2) * Ds * N_plus_1; 
den_s = 5.22e10 * De * s * phi_s; 
delta_Ps = num_s / den_s; 

% --- 2. Tube-side Return Pressure Drop (Delta Pr) 
delta_Pr = (4 * n_passes / S_tube) * v_sq_2g; 

% --- 3. Total Pressure Drop (Corrected Sum) 
% Updated logic: Shell Drop + Return Drop
delta_PT_corrected = delta_Ps + delta_Pr; 

% Output
fprintf('--- UPDATED PRESSURE DROP CALCULATION ---\n');
fprintf('Shell-side Pressure Drop (Delta Ps): %.2f psi\n', delta_Ps);
fprintf('Tube-side Return Drop (Delta Pr):    %.2f psi\n', delta_Pr);
fprintf('Corrected Total Pressure Drop:       %.2f psi\n', delta_PT_corrected);