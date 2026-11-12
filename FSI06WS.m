clc;clear;clf;

R = 20;
L = 0.05;
cphi = 0.1;
I0 = 1*10^(-4);
U = 24;
M = 0;
step_t = 0;
omega_zadana = 100;

U_DC = 20;
s = 0.5;
F_pwm = [100, 1000, 10000];
f_pwm = F_pwm(1);

regulator_P = 2;
regulator_I = 6;
regulator_D = 0;
regulator_N = 100;

mdl = 'FSI06';
load_system(mdl)

%% DC motor s frekvencnim menicem

figure(1)
for i = 1:length(F_pwm)
    pause(1)
    f_pwm = F_pwm(i);
    out = sim(mdl);
    t = out.tout;
    omega = out.ScopeData.signals(1).values;
    I = out.ScopeData.signals(2).values;
    subplot(length(F_pwm),2,i+i-1)
    plot(t,omega)
    xlabel("t[s]")
    ylabel("w[rad/s]")
    legend('omega/čas');
    subplot(length(F_pwm),2,i+i)
    plot(t,I)
    xlabel("t[s]")
    ylabel("I[A]")
    legend('proud/čas');
    title(sprintf('s PWM o f = %.2f Hz', f_pwm))
end

%% DC motor s regulaci otacek

pause(1)
figure(2)

M = 0.2;
step_t = 1;
omega_zadana = 100;

out = sim(mdl);
t = out.tout;
omega = out.ScopeData1.signals(1).values;
I = out.ScopeData1.signals(2).values;

subplot(2,1,1);
plot(t,omega,LineWidth=2)
xlabel("t[s]")
ylabel("w[rad/s]")
legend('omega/čas - heuristické parametry');
subplot(2,1,2);
plot(t,I,LineWidth=2)
xlabel("t[s]")
ylabel("I[A]")
legend('proud/čas - heuristické parametry');

% autotune
pause(1)
figure(3)

regulator_P = 0.198587287249738;
regulator_I = 1.2694853061866;
regulator_D = 0.00312170937886235;
regulator_N = 18.3256271878837;

out = sim(mdl);
t = out.tout;
omega = out.ScopeData1.signals(1).values;
I = out.ScopeData1.signals(2).values;

subplot(2,1,1);
plot(t,omega,LineWidth=2)
xlabel("t[s]")
ylabel("w[rad/s]")
legend('omega/čas - autotune parametry');
subplot(2,1,2);
plot(t,I,LineWidth=2)
xlabel("t[s]")
ylabel("I[A]")
legend('proud/čas - autotune parametry');