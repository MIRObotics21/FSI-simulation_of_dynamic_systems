function [y_dot] = odeFcnForceExc(m,b,k,F,omega,t,y)
    y_dot(1) = y(2);
    y_dot(2) = -1/m*(b*y(2)+k*y(1)-F*sin(omega*t));
    y_dot = y_dot';
end