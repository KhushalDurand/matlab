%% Shell & Tube Heat Exchanger Design (Distilled Water-Raw Water)
clear; clc;

%% 1. Input Data
% Temperatures (F)
T1 = 93;    T2 = 85;   % Hot fluid (Distilled Water - Shell side)
t1 = 75;    t2 = 80;   % Cold fluid (Raw Water - Tube side)

% Flow rates (lb/hr)
W_d = 175046;          % Distilled water flow
W_r = 279954;          % Raw water flow
Cp = 1.0;              % Specific heat for water (Btu/lb-F)

% Exchanger Specifications
ID_shell = 15.25;      % Shell ID (in)
N_tubes = 160;         % Number of tubes
L_tube = 16;           % Tube length (ft)
OD_tube = 0.75;        % Tube OD (in)
Passes_tube = 2;       % Tube passes
Baffle_space = 12;     % Baffle spacing (in)
Allowable_dP = 10.0;   % Allowable pressure drop (psi)

%% 2. Heat Balance & LMTD
% Heat Load (Q)
Q_h = W_d * Cp * (T1 - T2);
Q_c = W_r * Cp * (t2 - t1);
Q_avg = (Q_h + Q_c) / 2;

% LMTD Calculation
dT1 = T1 - t2;         % Approach 1
dT2 = T2 - t1;         % Approach 2
LMTD = (dT1 - dT2) / log(dT1 / dT2);

% LMTD Correction Factor (Ft) for 1-2 Exchanger
R = (T1 - T2) / (t2 - t1);
S = (t2 - t1) / (T1 - t1);
Ft = 0.96;             % From Kern Figure 18/provided slide
dT_corrected = LMTD * Ft;

%% 3. Hydraulic Performance
% Constants for calculation (from provided slides)
f_shell = 0.0021;      
f_tube = 0.0016;
V_tube = 6.7;          % Tube velocity (fps)

% Shell Side Pressure Drop (dPs)
dPs = 8.478;           % Result from hydraulic check slide (psi)

% Tube Side Pressure Drop (dPT)
dPt_friction = 4.092;  % Friction loss
dPr_return = 2.24;     % Return loss
dPT = dPt_friction + dPr_return;

%% 4. Design Summary & Verdict
fprintf('--- DESIGN SUMMARY: TUTORIAL 2 ---\n');
fprintf('Heat Load (Q):         %.0f Btu/hr\n', Q_avg);
fprintf('LMTD (Uncorrected):    %.2f F\n', LMTD);
fprintf('LMTD (Corrected):      %.2f F\n', dT_corrected);
fprintf('----------------------------------\n');
fprintf('Shell-side dP:         %.3f psi (Limit: 10.0)\n', dPs);
fprintf('Tube-side dP:          %.3f psi (Limit: 10.0)\n', dPT);
fprintf('Tube Velocity:         %.1f fps  (Min: 6.0)\n', V_tube);
fprintf('----------------------------------\n');

if dPs < Allowable_dP && dPT < Allowable_dP && V_tube > 6.0
    fprintf('FINAL VERDICT:         SATISFACTORY\n');
else
    fprintf('FINAL VERDICT:         UNSATISFACTORY\n');
end
