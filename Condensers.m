%% Mixed Light Hydrocarbon Condenser Design
clear; clc;

%% 1. Input Data & Parameters
% Flow and Thermal Data
W = 45046;              % Vapor mass flow (kg/h)
H_v = 596.5;            % Enthalpy of vapor (kJ/kg)
H_l = 247.0;            % Enthalpy of condensate (kJ/kg)
Cp_water = 4.18;        % Sp. heat of cooling water (kJ/kg-C)

% Operating Temperatures (C)
T_in = 60;   T_out = 45; % Shell side (Hydrocarbon)
t_in = 30;   t_out = 40; % Tube side (Cooling water)

% Mechanical Specs
L_tube = 4.88;          % Tube length (m)
D_shell = 1.134;        % Shell inside diameter (m)
U_assumed = 900;        % Overall heat transfer coeff (W/m^2-C)

%% 2. Initial Thermal Calculations
% Heat Duty (Q)
Q_kW = (W / 3600) * (H_v - H_l); % 4373.2 kW

% Cooling Water Flow Rate (mw)
mw = Q_kW / (Cp_water * (t_out - t_in)); % 104.62 kg/s

% Log Mean Temperature Difference (LMTD)
dT1 = T_in - t_out;      % 60 - 40 = 20
dT2 = T_out - t_in;     % 45 - 30 = 15
LMTD = (dT1 - dT2) / log(dT1 / dT2);

% Corrected LMTD
Ft = 0.92;              % Correction factor
dT_corrected = Ft * LMTD; % 16.0 C

%% 3. Hydraulic Performance
% Shell Side Pressure Drop (dPs)
dPs_Pa = 1313;          % From calculation slide (Pa)
dPs_kPa = dPs_Pa / 1000;

% Tube Side Pressure Drop (dPt)
dPt_kPa = 53;           % From calculation slide (kPa)

%% 4. Design Summary & Verdict
fprintf('--- CONDENSER DESIGN SUMMARY ---\n');
fprintf('Total Heat Duty:       %.1f kW\n', Q_kW);
fprintf('Water Flow Rate:       %.2f kg/s\n', mw);
fprintf('Corrected LMTD:        %.1f C\n', dT_corrected);
fprintf('--------------------------------\n');
fprintf('Shell-side dP:         %.1f kPa (Negligible < 10)\n', dPs_kPa);
fprintf('Tube-side dP:          %.0f kPa (Acceptable < 70)\n', dPt_kPa);
fprintf('--------------------------------\n');

if dPs_kPa < 10 && dPt_kPa < 70
    fprintf('FINAL VERDICT:         ACCEPTABLE\n');
else
    fprintf('FINAL VERDICT:         UNSATISFACTORY\n');
end
