clc;clf;clear;

a = -7;
v0 = 25;

mdl = 'FSI01_02';
load_system(mdl)
out = sim(mdl);

t = out.tout;
a = out.ScopeData2.signals(1).values;
v = out.ScopeData2.signals(2).values;
s = out.ScopeData2.signals(3).values;

clf;
subplot(3,1,1)
plot(t,a)
title("zrychleni-cas")
xlabel("t[s]")
ylabel("a[m/s^(2)]")
subplot(3,1,2)
plot(t,v)
title("rychlost-cas")
xlabel("t[s]")
ylabel("v[m/s]")
subplot(3,1,3)
plot(t,s)
title("draha-cas")
xlabel("t[s]")
ylabel("s[m]")

figure(2)
plot(s,v)
title("rychlost-draha")
xlabel("s[m]")
ylabel("v[m/s]")