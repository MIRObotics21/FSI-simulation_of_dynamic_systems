clc;clear;

%% 01 - horolezec
m = 70;
g = 10;
v_0 = 0;
v_max = 2;
b = 350;

%% 02 - RL
L = 0.02;
R = 5;
t1 = 0.1;
U = 10;
I0 = 0;

%% 3 - RC
C = 0.01;
R = 5;
U = 10;

%% main

mdl = 'FSI03';
load_system(mdl)
out = sim(mdl);
t = out.tout;

%01
v = out.EX1.signals.values;
figure(1)
plot(t,v)
xlabel("t[s]")
ylabel("v[m/s]")
legend("rychlost v čase")

%02
I = out.EX2.signals.values;
figure(2)
plot(t,I)
xlabel("t[s]")
ylabel("I[A]")
legend("proud v čase")

%03
I = out.EX3.signals.values;
figure(3)
plot(t,I)
xlabel("t[s]")
ylabel("I[A]")
legend("proud v čase")
