% Carlos Lazo
% EC504 - Homework #5
% Due: 10/13/09

clc; clear all; close all;

%% Problem #2

% Part(a)

% From the eigenvectors of Problem 1, we define our V & Lamdba matrices:

V     = [1 4 0; 0 1 0; 0 0 1];
V_inv = inv(V);

% Define derived eigenvalues:

L1 = 1;
L2 = 2;

% Compute L & exp(L):

syms t;

L     = diag([L1 L2 L2]);

L_exp = diag([exp(L1*t) exp(L2*t) exp(L2*t)]);

A1_et  = V * L_exp * V_inv;

display('A^et for Problem 2, Part 1 is:');
display(' ');

pretty(A1_et);

% Symbolic variable 'b' will represent base 2:

syms b;

L     = diag([(L1^100) b b])

A_100 = V * (L^100) * V_inv;

display('A^100 for Problem 2, Part 1 is:');
display(' ');

pretty(A_100);

% Part(b)

A2 = [0 1; 0 0]

A2_et = expm(A2*t);

display('A^et for Problem 2, Part 2 is:');
display(' ');

pretty(A2_et);

%% Problem #4

clc; clear all; close all;

% Solution 1

A = [0 1; -2 -2];
B = [1; 1];
C = [2 3];
D = [0];
I = eye(2);

syms s;

g_s = (C * (inv((s*I) - A)) * B) + D;

display('g(s) for Problem #4 in the Laplace domain is:');
display(' ');

simplify(g_s)

% Solution 2

syms t; syms T;

integrand = (expm(A*(t-T))) * B;

int_eval = int(integrand, T, 0, t);

display('With integral computation using the exp(A*t) definition, y(t) =');
display (' ');

y_t = C * int_eval