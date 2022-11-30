%% Results plots scripts (l-tuplesSGD vs mSGD vs SGD)
%% side by side

clc;clear

% Initializations

maxiter = 8*10^3;
p = 0.6;
p2 = 0.9;
ell = 10;
alpha = 10^-3;
RUNS = 20;

m = maxiter;
n = 30;
x_star = randn(n,1);


for i = 1:RUNS
    [~, x_err_tsgd(i,:), A, A_tilde, y] = ltuple_COMP(n, x_star, maxiter, p, ell, alpha);
    [~, x_err_msgd(i,:)] = mSGD_COMP(n, x_star, maxiter, p, ell, alpha);
end

for j = 1:RUNS
    [~, x_err_sgd(j,:)] = SGD_COMP2(A_tilde, x_star, y, maxiter, 0, alpha/3);
end

% 2
for i = 1:RUNS
    [~, x_err_tsgd2(i,:), A, A_tilde2, y] = ltuple_COMP(n, x_star, maxiter, p2, ell, alpha);
    [~, x_err_msgd2(i,:)] = mSGD_COMP(n, x_star, maxiter, p2, ell, alpha);
end

for j = 1:RUNS
    [~, x_err_sgd2(j,:)] = SGD_COMP2(A_tilde2, x_star, y, maxiter, 0, alpha/3);
end


ax1=subplot(1,2,1);
semilogy(1:maxiter, mean(x_err_tsgd,1),'-', 'DisplayName','l-tuple mSGD','Linewidth', 4, 'Color', 'b');
hold on
semilogy(1:maxiter, mean(x_err_msgd,1), ':','DisplayName','mSGD','Linewidth', 4, 'Color', 'r');
semilogy(1:maxiter, mean(x_err_sgd,1),'--','DisplayName','Vanilla SGD','Linewidth', 4, 'Color', '#EDB120');
xlabel('Iteration','FontSize',20);
ylabel('Error','FontSize',20);
legend show

ax2=subplot(1,2,2);
semilogy(1:maxiter, mean(x_err_tsgd2,1),'-', 'DisplayName','l-tuple mSGD','Linewidth', 4, 'Color', 'b');
hold on
semilogy(1:maxiter, mean(x_err_msgd2,1), ':','DisplayName','mSGD','Linewidth', 4, 'Color', 'r');
semilogy(1:maxiter, mean(x_err_sgd2,1),'--','DisplayName','Vanilla SGD','Linewidth', 4, 'Color', '#EDB120');
xlabel('Iteration','FontSize',20);
ylabel('Error','FontSize',20);
legend show

linkaxes([ax1, ax2], 'y');