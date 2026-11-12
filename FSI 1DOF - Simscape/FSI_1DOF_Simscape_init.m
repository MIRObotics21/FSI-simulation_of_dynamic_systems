%% FSI: 1DOF mechanical oscillator with variable excitation - Simscape
% Filip Kšica, © VUT 2025

clc;close all;clear all;

%% Parameters
m = 4;                      % [kg] mass
Q = 80;                     % [-] quality factor
freq_0 = 10;                % [Hz] natural frequency
omega_0 = 2*pi*freq_0;      % [rads-1] natural frequency
b = (2*m*omega_0)/(2*Q);    % [Nsm-1] damping
k = omega_0^2*m;            % [Nm-1] stiffness

% b = 5;                      % [Nsm-1]
% k = 1e4;                    % [Nm-1]

%% Initial conditions
x_0 = 0.001;                    % [m] initial displacement
v_0 = -0.02;                    % [ms-1] initial velocity

%% Excitation
% Force amplitude
F_exc = 10;                 % [N] amplitude of excitation force

% Harmonic
freq_exc = 10;              % [Hz] excitation frequency
omega_exc = 2*pi*freq_exc;  % [rads-1] excitation frequency
phase_exc = 0;              % [rad] phase shift 
bias_exc = 0;               % [-] bias

% Impulse
t_step = 1e-2;              % [s] step width
