clear;clc;clf;close all;

global num_of_plotik;
num_of_plotik = 1;

%% zadani
m = 4;
f0 = 10;
Q = 80;
x0 = 0.001;
v0 = -0.02;
F = 10;
f = 5;

%% 01
omega0 = 2*pi*f0;
k = m*omega0^2;
b = (m*omega0)/(Q);
bp = b/m;
delta = bp*(2*pi*f0);

%% 02
% F = mx''+bx'+kx

%% 03
% x'' = (1/m)*(F-x'-kx)

%% 04 a 05
mdl0 = 'FSI09_0';
load_system(mdl0)

%% 06
swich = 1;
t_stop = 10;
Ts = 2e-3;
set_param(mdl0, 'StopTime', 't_stop');
out = sim(mdl0);

t0_1 = out.tout;
u0_1 = out.ScopeData.signals(1).values;
x0_1 = out.ScopeData.signals(2).values;
v0_1 = out.ScopeData.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t0_1,x0_1,LineWidth=1.5)
xlabel("t[s]")
ylabel("x[m]")
legend("výchylka v čase")
title("buzení f(t)=5.sin(2*pi*5*t)")
subplot(2,1,2)
plot(t0_1,v0_1,LineWidth=1.5)
xlabel("t[s]")
ylabel("v[m/s]")
legend("rychlost v čase")

%% 07
figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
plot(x0_1,v0_1,LineWidth=1.5)
xlabel("x[m]")
ylabel("v[m/s]")
title("fázová rovina při buzení f(t)=5.sin(2*pi*5*t)")

%% 08
F = 0;
out = sim(mdl0);
t0_2 = out.tout;
u0_2 = out.ScopeData.signals(1).values;
x0_2 = out.ScopeData.signals(2).values;
v0_2 = out.ScopeData.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t0_2,x0_2,LineWidth=1.5)
xlabel("t[s]")
ylabel("x[m]")
legend("výchylka v čase")
title("buzení f(t)=0")
subplot(2,1,2)
plot(t0_2,v0_2,LineWidth=1.5)
xlabel("t[s]")
ylabel("v[m/s]")
legend("rychlost v čase")

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
plot(x0_2,v0_2,LineWidth=1.5)
xlabel("x[m]")
ylabel("v[m/s]")
title("fázová rovina při buzení f(t)=0")

%% 09
swich = -1;
t_sims = [20 200 600];
x0 = 0;
v0 = 0;
figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;

for i = 1:length(t_sims)
    pause(1)
    t_stop = t_sims(i);
    set_param(mdl0, 'StopTime', 't_stop');
    out = sim(mdl0);

    x9 = out.ScopeData.signals(2).values;
    frequencies = 0:(20/(length(x9)-1)):20;
    
    subplot(length(t_sims),1,i)
    plot(frequencies,x9)
    xlabel("f[Hz]")
    ylabel("x[m]")
    legend(sprintf('chirp se sim. čas = %.2f s', t_stop));
end

%% 10
% konvergence umira kolem:
% Ts = 3e-2;

%% 11
mdl1 = 'FSI09_1';
load_system(mdl1)
swich = 1;
t_stop = 10;
F = 10;
x0 = 0.001;
v0 = -0.02;

out = sim(mdl1);
t1_1 = out.tout;
u1_1 = out.ScopeData1.signals(1).values;
x1_1 = out.ScopeData1.signals(2).values;
v1_1 = out.ScopeData1.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t1_1,x1_1,LineWidth=1.5)
xlabel("t[s]")
ylabel("x[m]")
legend("výchylka v čase")
title("simscape - buzení f(t)=5.sin(2*pi*5*t)")
subplot(2,1,2)
plot(t1_1,v1_1,LineWidth=1.5)
xlabel("t[s]")
ylabel("v[m/s]")
legend("rychlost v čase")

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
plot(x1_1,v1_1,LineWidth=1.5)
xlabel("x[m]")
ylabel("v[m/s]")
title("simscape - fázová rovina při buzení f(t)=5.sin(2*pi*5*t)")

% bez buzeni
F = 0;

out = sim(mdl1);
t1_1 = out.tout;
u1_1 = out.ScopeData1.signals(1).values;
x1_1 = out.ScopeData1.signals(2).values;
v1_1 = out.ScopeData1.signals(3).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t1_1,x1_1,LineWidth=1.5)
xlabel("t[s]")
ylabel("x[m]")
legend("výchylka v čase")
title("simscape - buzení f(t)=0")
subplot(2,1,2)
plot(t1_1,v1_1,LineWidth=1.5)
xlabel("t[s]")
ylabel("v[m/s]")
legend("rychlost v čase")

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
plot(x1_1,v1_1,LineWidth=1.5)
xlabel("x[m]")
ylabel("v[m/s]")
title("simscape - fázová rovina při buzení f(t)=0")

%% 12
x0 = 0.001;
v0 = -0.02;
% x0 = 0;
% v0 = 0;

A = [0 1;-k/m -b/m];
B = [0;1/m];
C = [1 0];
D = [0];

SS1DOF = ss(A,B,C,D);
[num, den] = ss2tf(A,B,C,D);
tf1 = tf(num,den);

mdl2 = 'FSI09_2';
load_system(mdl2)
t_stop = 10;
swich = 1;

F = 10;
out = sim(mdl2);
t2 = out.tout;
x21_ss = out.ScopeData10.signals(1).values;
x21_tf = out.ScopeData10.signals(2).values;
v21_ss = out.ScopeData10.signals(3).values;
v21_tf = out.ScopeData10.signals(4).values;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(2,1,1)
plot(t2,x21_ss,'b',t2,x21_tf,'r',t0_1,x0_1,'g--',LineWidth=1)
legend('state-space','transfer fction','manual simulink z n.6')
xlabel("t[s]")
ylabel("x[m]")
title('porovnaní pro případ s buzením')
subplot(2,1,2)
plot(t2,v21_ss,'b',t2,v21_tf,'r',t0_1,v0_1,'g--',LineWidth=1)
legend('state-space','transfer fction','manual simulink z n.6')
xlabel("t[s]")
ylabel("v[m/s]")

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
plot(x21_ss,v21_ss,'b',x21_tf,v21_tf,'r',x0_1,v0_1,'g--',LineWidth=1)
xlabel("x[m]")
ylabel("v[m/s]")
title("fázová rovina pro případ s buzením")
legend('state-space','transfer fction','manual simulink z n.6')

t_stop = 600;
swich = -1;
x0 = 0;
v0 = 0;
out = sim(mdl2);

x10 = out.ScopeData10.signals(1).values;
x11 = out.ScopeData10.signals(2).values;
frequencies = 0:(20/(length(x10)-1)):20;

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;
subplot(3,1,1)
plot(frequencies,x9)
xlabel("f[Hz]")
ylabel("x[m]")
legend('simulink');
subplot(3,1,2)
plot(frequencies,x10)
xlabel("f[Hz]")
ylabel("x[m]")
legend('ss');
subplot(3,1,3)
plot(frequencies,x11)
xlabel("f[Hz]")
ylabel("x[m]")
legend('tf');

%% poznamky z cviceni - second lesson
% f = 1.5;
% omega = 2*pi*f;
% 
% t = 1:1e-3:20;
% 
% F = 1*0;
% 
% m = 5;
% b = 3;
% k = 140;
% 
% x_0 = 0;
% x_dot_0 = 1;
% initial_conditions = [x_0,x_dot_0];
% [T,Y] = ode45(@(t,y) odeFcnForceExc(m,b,k,F,omega,t,y), t, initial_conditions);
% 
% figure(1)
% plot(T,Y(:,1),T,Y(:,2)) % vychylka a rychlost
% figure(2)
% plot(Y(:,1),Y(:,2))
% 
% tf_1DOF = tf([1],[m,b,k]);
% % bode diagram
% n_freq = 1000;
% freq_bode = linspace(1,1*pi*4,n_freq);
% bode_opt = bodeoptions("cstprefs");
% bode_opt.FreqUnits = 'Hz';
% bode_opt.FreqScale = 'linear';
% bode_opt.MagUnits = 'abs';
% bode_opt.MagScale = 'linear';
% bode(tf_1DOF,freq_bode,bode_opt)
% 
% A = [0 1;-k/m -b/m];
% B = [0;1/m];
% C = [1 0;0 1];
% D = [0;0];
% 
% SS1DOF = ss(A,B,C,D);
% % [num, den] = ss2tf(A,B,C,D);
% % tf1 = tf(num,den);