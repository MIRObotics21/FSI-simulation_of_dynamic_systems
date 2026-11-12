clear;clc;clf;

R = 20;
L = 0.05;
cphi = 0.1;
I0 = 1*10^(-4);
U = 24;
M = 0;
step_t = 0;

mdl = 'FSI05';
load_system(mdl)

%% bez zateze
out = sim(mdl);
t = out.tout;
omega = out.ScopeData.signals(1).values;
I = out.ScopeData.signals(2).values;

figure(1)
subplot(2,1,1);
plot(t,omega,LineWidth=2)
xlabel("t[s]")
ylabel("w[rad/s]")
legend('omega/čas');
subplot(2,1,2);
plot(t,I,LineWidth=2)
xlabel("t[s]")
ylabel("I[A]")
legend('proud/čas');

%% se zatezi
M = 0.02;
step_t = 2;

out = sim(mdl);
t = out.tout;
omega = out.ScopeData.signals(1).values;
I = out.ScopeData.signals(2).values;

figure(2)
subplot(2,1,1);
plot(t,omega,LineWidth=2)
xlabel("t[s]")
ylabel("w[rad/s]")
legend('omega/čas');
subplot(2,1,2);
plot(t,I,LineWidth=2)
xlabel("t[s]")
ylabel("I[A]")
legend('proud/čas');

%% bez odporu
R = 0;
M = 0;

out = sim(mdl);
t = out.tout;
omega = out.ScopeData.signals(1).values;
I = out.ScopeData.signals(2).values;

figure(3)
subplot(2,1,1);
plot(t,omega)
xlabel("t[s]")
ylabel("w[rad/s]")
legend('omega/čas');
subplot(2,1,2);
plot(t,I)
xlabel("t[s]")
ylabel("I[A]")
legend('proud/čas');