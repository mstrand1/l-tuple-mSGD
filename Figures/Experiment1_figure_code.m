%% Experiment 1
%% msgd & l-tuple msgd comparison (l-tuple mSGD recovers mSGD with ell = 1)

clc;clear

% Initializations
maxiter = 10^4;
m = maxiter;
n = 25;
x_star = randn(n,1);

RUNS = 20;

p = [0.8, 0.95, 0.999];
ell = 1;
alpha = 10^-3;

for i = 1:RUNS
    [~, x_err_l1(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(1), ell, alpha); 
    [~, x_err_l2(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(2), ell, alpha); 
    [~, x_err_l3(i,:), ~, ~, ~] = ltuple_COMP(n, x_star, maxiter, p(3), ell, alpha); 
    
    [~, x_err_m1(i,:)] = mSGD_COMP(n, x_star, maxiter, p(1), ell, alpha);
    [~, x_err_m2(i,:)] = mSGD_COMP(n, x_star, maxiter, p(2), ell, alpha);
    [~, x_err_m3(i,:)] = mSGD_COMP(n, x_star, maxiter, p(3), ell, alpha);
end

% Plots (residual and actual error)
semilogy(1:maxiter, mean(x_err_l1,1),':','MarkerSize', 6,'MarkerIndices',1:maxiter/10:maxiter,'DisplayName','l-tuple mSGD : p = 0.8','Linewidth', 3, 'Color','b');
hold on
semilogy(1:maxiter, mean(x_err_l2,1),'-.', 'MarkerSize', 6,'MarkerIndices',1:maxiter/10:maxiter, 'DisplayName','l-tuple mSGD : p = 0.9','Linewidth', 3, 'Color','b');
semilogy(1:maxiter, mean(x_err_l3,1), '-','MarkerSize', 6,'MarkerIndices',1:maxiter/10:maxiter,'DisplayName','l-tuple mSGD : p = 0.999','Linewidth', 3, 'Color','b');
semilogy(1:maxiter, mean(x_err_m1,1), ':','MarkerSize', 6,'MarkerIndices',1:maxiter/10:maxiter,'DisplayName','mSGD : p = 0.8','Linewidth', 3, 'Color','r');
semilogy(1:maxiter, mean(x_err_m2,1),'-.','MarkerSize', 6,'MarkerIndices',1:maxiter/10:maxiter,'DisplayName','mSGD : p = 0.9','Linewidth', 3, 'Color','r');
semilogy(1:maxiter, mean(x_err_m3,1),'-','MarkerSize', 6,'MarkerIndices',1:maxiter/10:maxiter,'DisplayName','mSGD : p = 0.999','Linewidth', 3, 'Color','r');
xlabel('Iteration', 'FontSize', 20);
ylabel('Error', 'FontSize', 20);
legend show