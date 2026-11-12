clc;clear;clf;

R = 20;
L = 0.05;
cphi = 0.1;
I0 = 1*10^(-4);

M = 0;
step_t = 0;
omega_zadana = 0;
I_zadana = 0;

I_regulator_P = 1000;
I_regulator_I = 100000;
I_regulator_D = 0;
I_regulator_N = 0;
w_regulator_P = 4;
w_regulator_I = 10;
w_regulator_D = 0;
w_regulator_N = 0;
saturator = inf;
integrator = inf;

mdl = 'FSI07';
load_system(mdl)

%% DC motor s regulaci proudu
% pause(1)
% figure(1)
% 
% I_regulator_P = 1000;
% I_regulator_I = 100000;
% I_regulator_D = 0;
% I_regulator_N = 100;
% t_stop = 1e-3;
% 
% % I_regulator_P = 25.0982124368276;
% % I_regulator_I = 10949.0907052805;
% % I_regulator_D = 0.00315052337511684;
% % I_regulator_N = 887.907904569917;
% % t_stop = 0.02;
% 
% I_zadana = 0.5;
% 
% set_param(mdl, 'StopTime', 't_stop');
% out = sim(mdl);
% t = out.tout;
% I = out.ScopeData1.signals(2).values;
% 
% plot(t,I,LineWidth=2)
% xlabel("t[s]")
% ylabel("I[A]")
% legend('proud/čas');

%% DC motor s regulaci proudu a otacek
% pause(1)
% figure(2)
% 
% w_regulator_P = 4;
% w_regulator_I = 10;
% w_regulator_D = 0;
% w_regulator_N = 0;
% 
% omega_zadana = 100;
% M = 10;
% step_t = 0.5;
% 
% t_stop = 1;
% set_param(mdl, 'StopTime', 't_stop');
% out = sim(mdl);
% t = out.tout;
% omega = out.ScopeData2.signals(1).values;
% I = out.ScopeData2.signals(2).values;
% 
% subplot(2,1,1);
% plot(t,omega,LineWidth=2)
% xlabel("t[s]")
% ylabel("w[rad/s]")
% legend('omega/čas');
% subplot(2,1,2);
% plot(t,I,LineWidth=2)
% xlabel("t[s]")
% ylabel("I[A]")
% legend('proud/čas');

%% DC motor s regulaci proudu a otacek, saturaci
% pause(1)
% figure(3)
% 
% omega_zadana = 100;
% M = 0;
% step_t = 0;
% 
% w_regulator_P = 0;      % full anti wind up
% w_regulator_P = 4;
% w_regulator_I = 100;
% w_regulator_D = 0;
% w_regulator_N = 0;
% saturator = 0.5;
% 
% t_stop = 5;            % full anti wind up
% % t_stop = 1.5; 
% set_param(mdl, 'StopTime', 't_stop');
% out = sim(mdl);
% t = out.tout;
% omega = out.ScopeData3.signals(1).values;
% I = out.ScopeData3.signals(2).values;
% vystup_omega_PID = out.ScopeData3.signals(3).values;
% vstup_omega_PID = out.ScopeData3.signals(4).values;
% vystup_po_saturaci = out.ScopeData3.signals(5).values;
% 
% subplot(5,1,1);
% plot(t,omega,LineWidth=2)
% xlabel("t[s]")
% ylabel("w[rad/s]")
% legend('omega/čas');
% subplot(5,1,2);
% plot(t,I,LineWidth=2)
% xlabel("t[s]")
% ylabel("I[A]")
% legend('proud/čas');
% subplot(5,1,3);
% plot(t,vstup_omega_PID,LineWidth=2)
% xlabel("t[s]")
% ylabel("w[rad/s]")
% legend('rozdíl otáček (vstup do PID otáček)/čas');
% subplot(5,1,4);
% plot(t,vystup_omega_PID,LineWidth=2)
% xlabel("t[s]")
% ylabel("I[A]")
% legend('žádaný proud (výstup PID otáček)/čas');
% subplot(5,1,5);
% plot(t,vystup_po_saturaci,LineWidth=2) %bipolarni regulator hihi
% xlabel("t[s]")
% ylabel("I[A]")
% legend('saturovaný žádaný proud/čas');

%% DC motor s regulaci proudu a otacek, saturaci a anti-wind-up
pause(1)
figure(4)

omega_zadana = 100;
M = 0.04;
step_t = 0.5;

w_regulator_P = 4;
w_regulator_I = 100;
w_regulator_D = 0;
w_regulator_N = 0;
saturator = 0.5;
integrator = 10;

t_stop = 1;
set_param(mdl, 'StopTime', 't_stop');
out = sim(mdl);
t = out.tout;
omega = out.ScopeData3.signals(1).values;
I = out.ScopeData3.signals(2).values;
vystup_omega_PID = out.ScopeData3.signals(3).values;
vstup_omega_PID = out.ScopeData3.signals(4).values;
vystup_po_saturaci = out.ScopeData3.signals(5).values;

subplot(5,1,1);
plot(t,omega,LineWidth=2)
xlabel("t[s]")
ylabel("w[rad/s]")
legend('omega/čas');
subplot(5,1,2);
plot(t,I,LineWidth=2)
xlabel("t[s]")
ylabel("I[A]")
legend('proud/čas');
subplot(5,1,3);
plot(t,vstup_omega_PID,LineWidth=2)
xlabel("t[s]")
ylabel("w[rad/s]")
legend('rozdíl otáček (vstup do PID otáček)/čas');
subplot(5,1,4);
plot(t,vystup_omega_PID,LineWidth=2)
xlabel("t[s]")
ylabel("I[A]")
legend('žádaný proud (výstup PID otáček)/čas');
subplot(5,1,5);
plot(t,vystup_po_saturaci,LineWidth=2)
xlabel("t[s]")
ylabel("I[A]")
legend('saturovaný žádaný proud/čas');