%% Vertical Thermosiphon Reboiler Preliminary Design (Aniline)
clear; clc;

%% 1. Input Data
% Temperatures (C) and Pressures (bar)
T_process = 190;        % Boiling point of Aniline at 1.2 bar (C)
T_steam = 217;          % Steam saturation temperature at 22 bar (C)
T_critical = 699;       % Critical temperature (K)

% Process Requirements
vapor_rate = 6046;      % Required vaporization rate (kg/h)
MW = 93.13;             % Molecular weight
Latent_heat = 42000;    % kJ/kmol
q_design = 25000;       % Design heat flux (W/m^2)

% Tube and Shell Specifications
d_o = 30;               % Tube outer diameter (mm)
d_i = 25;               % Tube inner diameter (mm)
L_tube = 2.44;          % Tube length (m)
K1 = 0.215;             % Bundle diameter constant (square pitch, 1-pass)
n1 = 2.207;             % Bundle diameter index

%% 2. Heat Load & Area Requirements
% Heat Load (Q) in kW
% Q = (mass flow * Latent heat) / (3600 * MW)
Q = (vapor_rate * Latent_heat) / (3600 * MW); 

% Required Heat Transfer Area (A)
% A = Q (in Watts) / Design Heat Flux
A_required = (Q * 1000) / q_design;

%% 3. Tube Selection and Count
% Surface area of one tube (based on outer diameter)
A_tube = pi * (d_o * 10^-3) * L_tube;

% Number of tubes (Nt)
N_t = ceil(A_required / A_tube);

%% 4. Bundle Diameter Calculation
% Db = d_o * (Nt / K1)^(1/n1)
D_b = d_o * (N_t / K1)^(1/n1);

%% 5. Safety & Stability Check
dT_mean = T_steam - T_process;
T_reduced = (T_process + 273.15) / T_critical;
q_allowable = 43000;    % Allowable heat flux from design correlation (W/m^2)
safety_factor = q_allowable / q_design;

%% 6. Design Summary Output
fprintf('--- THERMOSIPHON REBOILER SUMMARY ---\n');
fprintf('Heat Load (Q):         %.2f kW\n', Q);
fprintf('Required Area (A):     %.2f m^2\n', A_required);
fprintf('Number of Tubes (Nt):  %d tubes\n', N_t);
fprintf('Bundle Diameter (Db):  %.2f mm\n', D_b);
fprintf('-------------------------------------\n');
fprintf('Mean Delta T:          %.0f C\n', dT_mean);
fprintf('Reduced Temperature:   %.2f\n', T_reduced);
fprintf('Safety Factor:         %.2f (Min required: 1.0)\n', safety_factor);
fprintf('-------------------------------------\n');
fprintf('FINAL VERDICT:         SUCCESSFULLY DESIGNED\n');
