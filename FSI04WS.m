clear;clc;clf;

m = 2;
b = 5;
k = 50000;
x0 = 1;
omega = sqrt(k/m);
chirp_start = 10;
chirp_end = 10; %actuall změnu chirpu provedte ve spodni sekci chirpik
t_start = 0;

mdl = 'FSI04';
load_system(mdl)

%% volna odezva
switch_con_sin = 1;
switch_cs_chirp = 1;
t_stop = 3;
set_param(mdl, 'StopTime', 't_stop');
out = sim(mdl);
t = out.tout;
x = out.ScopeDataComplete.signals(2).values;
figure(1)
plot(t,x)
delta = b/(2*m);
A = 1+exp(-delta*t);
hold on
plot(t,A)
xlabel("t[s]")
ylabel("x[m]")
legend("výchylka v čase","obálka exp(-delta*t)")

%% silove buzeni - ruzne frekvence
pause(2)
figure(2)
switch_con_sin = -1;
switch_cs_chirp = 1;
omegas = [sqrt(k/m) sqrt(k/m)*1.5 sqrt(k/m)*2 sqrt(k/m)/1.5 sqrt(k/m)/2];
num_of_sin = length(omegas);
for i=1:num_of_sin
    omega = omegas(i);
    out = sim(mdl);
    t = out.tout;
    x2 = out.ScopeDataComplete.signals(2).values;
    x2_source = out.ScopeDataComplete.signals(1).values;
    subplot(num_of_sin,2,i+i-1)
    plot(t,x2)
    xlabel("t[s]")
    ylabel("x[m]")
    legend(sprintf('out for omega = %.2f rad/s', omega));
    subplot(num_of_sin,2,i+i)
    plot(t,x2_source)
    xlabel("t[s]")
    ylabel("x[m]")
    legend(sprintf('omega = %.2f rad/s', omega));
end

%% silove buzeni - chirpik
pause(2)
figure(3)
switch_con_sin = -1;
switch_cs_chirp = -1;
t_stop = 500;
set_param(mdl, 'StopTime', 't_stop');
chirp_start = 50; %hz
chirp_end = 0;

out = sim(mdl);
t = out.tout;
x3 = out.ScopeDataComplete.signals(2).values;
x3_source = out.ScopeDataComplete.signals(1).values;
[upper,lower] = envelope(x3);

subplot(2,1,1)
plot(t,x3_source)
xlabel("t[s]")
ylabel("x[m]")

legend(sprintf('source chirp with start at = %.2f Hz', chirp_start));

subplot(2,1,2)
f = chirp_end:(chirp_start/(length(t)-1)):chirp_start;
plot(f,x3)
hold on
plot(f,upper,LineWidth=2)
plot(f,lower,LineWidth=2)
xlabel("f[Hz]")
ylabel("x[m]")
legend("out",'upper envelope','lower envelope');