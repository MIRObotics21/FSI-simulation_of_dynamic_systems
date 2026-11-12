clc;clear;close all;
global num_of_plotik;
num_of_plotik = 1;

swich = 1;
Ts = 1e-3;
t_stop = 1;

L = 0.3;
m = 2;
m_zatez = 0.4;
k = 1480;

%% 01
I_rameno = (1/3)*m*L^2;
I = I_rameno;

%% 02
omega0 = sqrt(k/I_rameno);

%% 03
M = 0;
phi1 = 0;
omega1 = 0.5;
c = 1;
mdl = 'FSI10';
load_system(mdl)
out = sim(mdl);

t = out.tout;
phi_ref = out.ScopeData.signals(2).values;
omega_ref = out.ScopeData.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t,phi_ref,LineWidth=1.5)
ylabel('Phi[rad]')
xlabel('t[s]')
subplot(2,1,2)
plot(t,omega_ref,LineWidth=1.5)
ylabel('omega[rad/s]')
xlabel('t[s]')

%% 04
c = 0.5;
out = sim(mdl);

t = out.tout;
phi = out.ScopeData.signals(2).values;
omega = out.ScopeData.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t,phi,LineWidth=1.5)
ylabel('Phi[rad]')
xlabel('t[s]')
subplot(2,1,2)
plot(t,omega,LineWidth=1.5)
ylabel('omega[rad/s]')
xlabel('t[s]')

%% 05
c = 1;
I_bremeno = m_zatez*L^2;
I = I_rameno+I_bremeno;

out = sim(mdl);
t = out.tout;
phi = out.ScopeData.signals(2).values;
omega = out.ScopeData.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t,phi,t,phi_ref,LineWidth=1.5)
ylabel('Phi[rad]')
xlabel('t[s]')
legend('zatez','no zatez')
subplot(2,1,2)
plot(t,omega,t,omega_ref,LineWidth=1.5)
ylabel('omega[rad/s]')
xlabel('t[s]')
legend('zatez','no zatez')

%% 06
omega1 = 0;
M = 10*L;

out = sim(mdl);
t = out.tout;
phi = out.ScopeData.signals(2).values;
omega = out.ScopeData.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t,phi,LineWidth=1.5)
ylabel('Phi[rad]')
xlabel('t[s]')
subplot(2,1,2)
plot(t,omega,LineWidth=1.5)
ylabel('omega[rad/s]')
xlabel('t[s]')

swich = -1;
out = sim(mdl);
t = out.tout;
phi = out.ScopeData.signals(2).values;
omega = out.ScopeData.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t,phi,LineWidth=1.5)
ylabel('Phi[rad]')
xlabel('t[s]')
subplot(2,1,2)
plot(t,omega,LineWidth=1.5)
ylabel('omega[rad/s]')
xlabel('t[s]')