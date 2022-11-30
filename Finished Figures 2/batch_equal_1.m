% testereerere 
clc;clear

% Initializations
A = randn(1000,200);
x = randn(width(A),1);
y = A*x;
[m, n] = size(A);

maxiter = 10^5;
p = 0.9;
alpha = 5*10^-4;
ell = 10;
batch = 1;

%A = sym('a', [2 4]);
%A
%A'*A


[~, approx_err_batch, ~, ~] = ell_tuple_mb(A,x,y,maxiter,p,ell,batch,alpha,0);
[~, approx_err_sgd, ~, ~] = ltuple_mSGD(A, x, y, maxiter, p, ell, alpha);

% Plots (residual and actual error)
figure;

semilogy(1:maxiter, approx_err_batch,'DisplayName','Mini-batch GD batch = 1','Linewidth', 2);
hold on
semilogy(1:maxiter, approx_err_sgd,'DisplayName','l-tuple mSGD','Linewidth', 2);
xlabel('Iteration','FontSize',15);
ylabel('Error','FontSize',15);
title('l-tuple mSGD vs. mini-batch l-tuple GD with batch = 1','FontSize',15);
legend show