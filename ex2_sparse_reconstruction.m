clear all; close all;

n = 5000;
tlim = 1/8;
t = linspace(0, tlim, n);
k = [0:n-1];
f = sin(1394*pi*t) + sin(3266*pi*t);
ft = dct(f);

figure('name', 'A Tone Time and Frequency Plot');
subplot(2, 1, 1);
plot(t, f);
xlabel('Time (s)'); ylabel('f(t)');
axis([0 1/8 -2.5 2.5]);
subplot(2, 1, 2);
plot(k, ft);
xlabel('Frequency (Hz)'); ylabel('DCT(f(t))');
axis([100 500 -40 22]);

%% This is what we're going to work through ...
%%
%% PSI (n x n): DCT transform
%% c   (n x 1): Cosine transform coefficiencts
%% f   (n x 1): Original time signal
%%
%% PSI * c = f

%% b   (m x 1): Sparse samples from f (m << n)
%% PHI (m x n): Subset of randomly permuted identity matrix
%% f   (n x 1): Original time signal (same as above)
%%
%% b = PHI * f

%% A (m x n): PHI * PSI, but also equal to permuted columns of
%%            transformed identity matrix
%% x (n x 1): Sparse approximation to full PSI
%% b (m x 1): Sparse samples (same as above)
%%
%% A * x = b

%% Finally, we can reconstruct an approximation of the orignal:
%%
%% f = PSI * x (approximately)

%% First, grab 500 random points from f
m = 500;
r1 = randintrlv([1:n],793);
perm = r1(1:m);
f2 = f(perm);
t2 = t(perm);

%% Then build A = PHI * PSI by grabbing permuted rows of transformed
%% identity matrix.
D = dct(eye(n, n));
A = D(perm, :);

%% Compare 3 different solutions
x = pinv(A) * f2';
x2 = A\f2';
cvx_begin;
  variable x3(n);
  minimize( norm(x3,1) );
  subject to
    A*x3 == f2';
cvx_end;

figure('name', 'Sparse Sample Solutions, Frequency Domain');
subplot(3, 1, 1);
plot(k, x);
ylabel('DCT(f(t))');
title('Using pinv()');
axis([100 500 -40 40]);
subplot(3, 1, 2);
plot(k, x2);
title('Using Backslash');
ylabel('DCT(f(t))');
axis([100 500 -40 40]);
subplot(3, 1, 3);
plot(k, x3);
title('Using L1 Norm');
ylabel('DCT(f(t))'); xlabel('Frequency (Hz)');
axis([100 500 -40 40]);

sig1 = dct(x);
sig2 = dct(x2);
sig3 = dct(x3);

figure('name', 'Sparse Sample Solutions, Time Domain');
subplot(3, 1, 1);
plot(t, sig1);
ylabel('f(t)');
title('Using pinv()');
axis([0 0.02 -2.5 2.5]);
subplot(3, 1, 2);
plot(t, sig2);
title('Using Backslash');
ylabel('f(t)');
axis([0 0.02 -2.5 2.5]);
subplot(3, 1, 3);
plot(t, sig3);
title('Using L1 Norm');
ylabel('DCT(f(t))'); xlabel('Time (s)');
axis([0 0.02 -2.5 2.5]);
