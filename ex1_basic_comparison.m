%% An example of solving an underdetermined system with various methods,
%% including the backslash function, the psuedoinverse, minimizing the
%% L1 norm, and minimizing the L2 norm.
%%
%% The results show that using the L1 norm is the best way to end up with
%% a sparse representation of the system.
clear all; close all;

m = 100; n = 500;
A = randn(m,n);
b = randn(m,1);
x1 = A\b;
x2 = pinv(A)*b;

cvx_begin;
  variable x3(n);
  minimize( norm(x3, 1) );
  subject to
    A * x3 == b;
cvx_end;

cvx_begin;
  variable x4(n);
  minimize( norm(x4, 2) );
  subject to
    A * x4 == b;
cvx_end;

figure('name', 'Sparsity of Solutions to 100 Equations x 500 Unknowns');
subplot(4,1,1);
hist(x1);
title('Backslash Method');
subplot(4,1,2);
hist(x2);
title('Using pinv()');
subplot(4,1,3);
hist(x3);
title('Minimizing L1 Norm');
subplot(4,1,4);
hist(x4);
title('Minimizing L2 Norm');
