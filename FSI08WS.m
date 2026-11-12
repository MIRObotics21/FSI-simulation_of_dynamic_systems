clear;clc;clf;close all;

global num_of_plotik;
num_of_plotik = 1;

%% buzeni z konst. frekvence
bp_range = [0 0.02 1 2];

figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;

mdl = 'FSI08';
load_system(mdl)
t_stop = 10;
Ts = 2e-3;
swich = 1;

F = 1;
m = 1;
f = 5;
k = (2*pi*f)^2*m;
f = 5;
omega = 2*pi*f;
x0 = 5e-2;
v0 = 0;

for i = 1:length(bp_range)
    bp = bp_range(i);
    delta = bp*(2*pi*f);
    b = delta*2*m;

    out = sim(mdl);

    t = out.tout;
    x = out.ScopeData.signals(2).values;
    subplot(length(bp_range),1,i)
    plot(t,x)
    xlabel("t[s]")
    ylabel("x[m]")
    legend(sprintf("výchylka v čase pro bp = %.2f",bp))
end

pause(1)
%% chirpy
figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;

bp_range = [0.02];
x0 = 0;
v0 = 0;
swich = -1;

for i = 1:length(bp_range)
    pause(1)

    bp = bp_range(i);
    delta = bp*(2*pi*f);
    b = delta*2*m;

    t_stop = 1000;
    out = sim(mdl);

    x = out.ScopeData.signals(2).values;
    frequencies = 0:(20/(length(x)-1)):20;

    subplot(length(bp_range),1,i)
    plot(frequencies,x)
    xlabel("f[Hz]")
    ylabel("x[m]")
    legend(sprintf("chirp pro bp = %.2f",bp))
end

pause(1)
%% fazove char
figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;

for i = 1:length(bp_range)
    pause(1)

    bp = bp_range(i);
    delta = bp*(2*pi*f);
    b = delta*2*m;

    t_stop = 100;
    out = sim(mdl);

    t = out.tout;
    x = out.ScopeData.signals(2).values;
    v = out.ScopeData.signals(3).values;
    subplot(length(bp_range),1,i)
    plot(x,v)
    xlabel("x[m]")
    ylabel("v[m/s]")
    legend("fázová charakteristika")
end


%% bodecko
figure(num_of_plotik)
num_of_plotik = num_of_plotik + 1;

m = 1;
f = 5;
bp = 0.02;
k = (2*pi*f)^2*m;
delta = bp*(2*pi*f);
b = delta*2*m;

tf_1DOF = tf([1],[m,b,k]);

% bode diagram
n_freq = 1000;
freq_bode = linspace(1,7*pi*7,n_freq);
bode_opt = bodeoptions("cstprefs");
bode_opt.FreqUnits = 'Hz';
bode_opt.FreqScale = 'linear';
bode_opt.MagUnits = 'abs';
bode_opt.MagScale = 'linear';
bode(tf_1DOF,freq_bode,bode_opt)