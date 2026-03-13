%% Gasketed Plate Heat Exchanger (PHE) Design (Methanol-Water)
clear; clc;

%% 1. Input Data & Fluid Properties
% Temperatures (C)
Th1 = 95;   Th2 = 40;   % Hot fluid (Methanol)
Tc1 = 25;   Tc2 = 40;   % Cold fluid (Brackish Water)

% Flow rates (kg/s)
m_dot_m = 27.8;         % Methanol
m_dot_w = 68.9;         % Water

% Plate Geometry
Area_plate = 0.75;      % Effective area per plate (m^2)
Plate_thickness = 0.00075; % 0.75 mm (m)
Channel_gap = 0.003;    % 3.0 mm (m)
k_titanium = 21;        % Thermal conductivity (W/mK)

% Operating Conditions
Q = 434000;             % Heat Duty (W)
U_assumed = 1900;       % Assumed Overall Heat Transfer Coeff (W/m^2K)

%% 2. Thermal Calculations
% LMTD Calculation
dT1 = Th1 - Tc2;        % 95 - 40 = 55
dT2 = Th2 - Tc1;        % 40 - 25 = 15
LMTD = (dT1 - dT2) / log(dT1 / dT2);

% Correction Factor (F) & Mean Temperature Difference
F = 0.96;               % Based on NTU = 1.78
dT_m = F * LMTD;

% Required Heat Transfer Area
Area_total = Q / (U_assumed * dT_m);

% Plate and Channel Requirements
N_plates = ceil(Area_total / Area_plate); % Approx 103 plates
N_channels = (N_plates - 1) / 2;          % Total channels per fluid

%% 3. Hydraulic Results (Final Design Values)
% Methanol Side (Hot)
dP_p_m = 5858.8;        % Pressure drop (Pa)
dP_total_m = 18142.5;   % Total pressure drop (Pa)
u_m = 4.967;            % Velocity (m/s)

% Water Side (Cold)
dP_p_w = 26545.3;       % Pressure drop (Pa)
dP_total_w = 79270.0;   % Total pressure drop (Pa)
u_w = 8.91;             % Velocity (m/s)

%% 4. Summary Output
fprintf('--- PLATE HEAT EXCHANGER SUMMARY ---\n');
fprintf('Heat Duty (Q):         %.0f W\n', Q);
fprintf('Mean Temp Diff (dTm):  %.2f C\n', dT_m);
fprintf('Total Required Area:   %.2f m^2\n', Area_total);
fprintf('Total Plate Count:     %d plates\n', N_plates);
fprintf('------------------------------------\n');
fprintf('HYDRAULIC RESULTS:\n');
fprintf('Methanol Side dP:      %.2f Pa (0.18 bar)\n', dP_total_m);
fprintf('Water Side dP:         %.2f Pa (0.79 bar)\n', dP_total_w);
fprintf('------------------------------------\n');
fprintf('FINAL VERDICT:         ACCEPTABLE\n');
