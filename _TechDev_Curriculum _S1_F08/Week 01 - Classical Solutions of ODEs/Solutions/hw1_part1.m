%% MCCCXXXVII TDCI HW #1
%% Classical Solutions to Differential Equations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Key Click Mode - Part d) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear MATLAB environment of all variables and open windows.

clear all;
close all;

%% Set coefficients and equations as derived for homework assignment.

b = 100;
a = 10^7;
w = sqrt(a^2-b^2);
B = j*w;
c1 = 9;
c2 = 9*10^-5;

%% Set sampling vector 't' to iterate over 750 bins.

t = 1:750;
n = 10000;
x = t*750/10000;

%% Plot derived differential equation with respect to t
%  with a sampling rate of n = 10000 per bin.

v(t) = exp(-b*t/n).*(c1*cos(w*t/n)+c2*cos(w*t/n));
hold on;
plot(x,v)
env(t) = c1*exp(-b*t/n);
plot(x,env,'r--');
plot(x,-env,'r--');
title ('Signal with Envelope');
xlabel (' Time (ms)');
ylabel (' Voltage (V)');


hold off;