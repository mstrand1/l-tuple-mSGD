%% Experiment 4
%% Mini batch size comparisons 

clc;clear

% Initializations
RUNS = 20;
maxiter = 6*10^3;

p = 0.95;
alpha = 10^-3;
ell = 5;

m = maxiter;
n = 50;
x = randn(n,1);

batch = [1, 4, 16, 32];

for i = 1:RUNS
    [~, x_err1(i,:)] = ltuple_mSGD_mb(n, x, maxiter, p, ell, batch(1), alpha);
    [~, x_err2(i,:)] = ltuple_mSGD_mb(n, x, maxiter, p, ell, batch(2), alpha);
    [~, x_err3(i,:)] = ltuple_mSGD_mb(n, x, maxiter, p, ell, batch(3), alpha);
    [~, x_err4(i,:)] = ltuple_mSGD_mb(n, x, maxiter, p, ell, batch(4), alpha);
end


semilogy(mean(x_err1,1), 'DisplayName','Batch = 1', 'Linestyle', '-', 'Linewidth', 4, 'Color', '#EDB120');
hold on
semilogy(mean(x_err2,1), 'DisplayName','Batch = 4', 'Linestyle', '--', 'Linewidth', 4, 'Color', 'b');
semilogy(mean(x_err3,1), 'DisplayName','Batch = 16', 'Linestyle', ':', 'Linewidth', 4, 'Color', 'g');
semilogy(mean(x_err4,1), 'DisplayName','Batch = 32', 'Linestyle', '-.', 'Linewidth', 4, 'Color', 'r');
ylabel('Error', 'FontSize', 20);
xlabel('Iteration', 'FontSize', 20);
legend show