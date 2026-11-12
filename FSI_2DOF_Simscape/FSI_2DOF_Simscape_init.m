%% FSI: 2DOF mechanical oscillator with variable excitation - Simscape
% Filip Kšica, © VUT 2025

%clc;close all;clear all;

%% Parameters
% Note: This input will demonstrate the effect of connecting two 1DOF systems with the same natural frequency
m1 = 1700;         % [kg] mass 1
m2 = 8.5;      % [kg] mass 2
k1 = 42e4;       % [Nm-1] stiffness 1
k2 = 2.1e3;     % [Nm-1] stiffness 2
b1 = 1.5e2;     % [Nsm-1] damping 1
b2 = 5;      % [Nsm-1] damping 2

%Q = 25;                     % [-] quality factor, Q = 1/(2*xi), Q_crit = 0.5
    
omega_01 = sqrt(k1/m1);     % [rads-1] natural frequency
f_01 = omega_01/(2*pi);     % [Hz] natural frequency 
xi_1 = b1/(2*m1*omega_01);
f_01d = f_01*sqrt(1-xi_1^2);
omega_02 = sqrt(k2/m2);
f_02 = omega_02/(2*pi);
xi_2 = b2/(2*m2*omega_02);
f_02d = f_02*sqrt(1-xi_2^2);


%% Initial conditions
x_10 = 0;                  	% [m] initial displacement
v_10 = 0;                   % [ms-1] initial velocity
x_20 = 0;                   % [m] initial displacement
v_20 = 0;                   % [ms-1] initial velocity

%% Excitation
% Force amplitudes
F_1 = 1e4;
F_2 = 0;

% Harmonic
bias_1 = 0;
f_1 = f_01;
omega_1 = 2*pi*f_1;
phase_1 = 0;

bias_2 = 0;
f_2 = f_02;
omega_2 = 2*pi*f_2;
phase_2 = 0;

% Impulse
t_1 = 1e-2;
t_2 = 1e-2;

