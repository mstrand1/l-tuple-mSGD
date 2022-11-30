% testereerere 
clc;clear

% Initializations
A = randn(1000,200);
x = randn(width(A),1);
y = A*x;
[m, n] = size(A);

maxiter = 3*10^3;
p = 0.9;
alpha = 5*10^-4;
ell = 10;
batch = [2^2, 2^3, 2^4, 2^5, 2^6, 1];

[~, approx_err_1, ~, ~] = ell_tuple_mb(A,x,y,maxiter,p,ell,batch(1),alpha,0);
[~, approx_err_2, ~, ~] = ell_tuple_mb(A,x,y,maxiter,p,ell,batch(2),alpha,0);
[~, approx_err_3, ~, ~] = ell_tuple_mb(A,x,y,maxiter,p,ell,batch(3),alpha,0);
[~, approx_err_4, ~, ~] = ell_tuple_mb(A,x,y,maxiter,p,ell,batch(4),alpha,0);
[~, approx_err_5, ~, ~] = ell_tuple_mb(A,x,y,maxiter,p,ell,batch(5),alpha,0);
[~, approx_err_0, ~, ~] = ell_tuple_mb(A,x,y,maxiter,p,ell,batch(6),alpha,0);

% Plots (residual and actual error)
figure;

semilogy(1:maxiter, approx_err_0,'DisplayName','Batch size = 1','Linewidth', 2);
hold on
semilogy(1:maxiter, approx_err_1,'DisplayName','Batch size = 4','Linewidth', 2);
semilogy(1:maxiter, approx_err_2,'DisplayName','Batch size = 8','Linewidth', 2);
semilogy(1:maxiter, approx_err_3,'DisplayName','Batch size = 16', 'Linewidth', 2);
semilogy(1:maxiter, approx_err_4,'DisplayName','Batch size = 32','Linewidth', 2);
semilogy(1:maxiter, approx_err_5,'DisplayName','Batch size = 64','Linewidth', 2);
xlabel('Iteration','FontSize',15);
ylabel('Error','FontSize',15);
title('Convergence comparisons for different batch sizes','FontSize',15);
legend show