clc;clf;clear;

x1 = 1;
figure(1)
mdl = 'FSI02';
load_system(mdl)

%% ode1
set_param(mdl,'Solver','ode1');
out = sim(mdl);
t = out.tout;
x = out.simout.signals.values;

plot(t,x)
hold on
xlabel("t")
ylabel("x(t)")

%% ode4
set_param(mdl,'Solver','ode4');
out = sim(mdl);
t = out.tout;
x = out.simout.signals.values;

plot(t,x,"--",LineWidth=1.5)

%% anal
x_alternate = @(t) exp(-t);

x_anal = x_alternate(t);
plot(t,x_anal)

legend("ode1","ode4","analyticky")
