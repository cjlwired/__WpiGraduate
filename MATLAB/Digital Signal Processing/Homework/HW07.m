% Carlos Lazo
% ECE 503
% Homework #7
% Due: 3/14/10

%% 1) Signal Sampling and Reconstruction

clear all; close all; clc;

% b. P&M 1.15

% Part (a)

% Define all equations and frequencies:

Fs   =   5e3;

Fo_1 =  .5e3;
Fo_2 =   2e3;
Fo_3 =   4e3;
Fo_4 = 4.5e3;

n = 0:99;

xn_1 = sin(2*pi*(Fo_1/Fs)*n);
xn_2 = sin(2*pi*(Fo_2/Fs)*n);
xn_3 = sin(2*pi*(Fo_3/Fs)*n);
xn_4 = sin(2*pi*(Fo_4/Fs)*n);

figure;
plot(n,xn_1);
xlabel('Samples');
ylabel('Amplitude');
title('x(n), Fs = 5kHz, Fo = 0.5kHz');

figure;
plot(n,xn_2);
xlabel('Samples');
ylabel('Amplitude');
title('x(n), Fs = 5kHz, Fo = 2kHz');

figure;
plot(n,xn_3);
xlabel('Samples');
ylabel('Amplitude');
title('x(n), Fs = 5kHz, Fo = 3kHz');

figure;
plot(n,xn_4);
xlabel('Samples');
ylabel('Amplitude');
title('x(n), Fs = 5kHz, Fo = 4.5kHz');

% Part (b)

Fs = 50e3;
Fo =  2e3;

x_n = sin(2*pi*(Fo/Fs)*n);

figure;
plot(n,x_n);
xlabel('Samples');
ylabel('Amplitude');
title('x(n), Fs = 50kHz, Fo = 2kHz');

n_y = 0:2:99;

y_n = sin(2*pi*(Fo/Fs)*n_y);

figure;
plot(n_y,y_n);
xlabel('Samples');
ylabel('Amplitude');
title('y(n), Fs = 50kHz, Fo = 2kHz');

%% 2) Filter Concepts

clear all; close all; clc;

% b. P&M 5.27

% Part (b)

b = [1 -1];
a = [1 .9];

freqz(b,a);

%% 2) Filter Concepts

clear all; close all; clc;

% c. P&M 5.34

w = 0:2*pi/1000:2*pi;

H_w = 1 + exp(-1*j*w) + exp(-2*j*w) + exp(-3*j*w) + exp(-4*j*w) + exp(-5*j*w) + exp(-6*j*w) + exp(-7*j*w) + exp(-8*j*w);

figure;

subplot(2,1,1);
plot(w, abs(H_w));
xlabel('w = 0:2*pi/1000:2*pi');
ylabel('Magnitutde');
title('|H(e^jw)|');
grid on;

subplot(2,1,2);
plot(angle(H_w));
xlabel('w = 0:2*pi/1000:2*pi');
ylabel('Magnitutde');
title('Phase[H(e^jw)]');
grid on;